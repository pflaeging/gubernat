#! env python3
# Hacked together by peter@pflaeging.net

import os, re, shutil, subprocess, yaml

def comment_yaml_if_ingress(filepath):
    with open(filepath, 'r') as f:
        lines = f.readlines()

    for line in lines:
        if line.strip():
            if line.strip() == "kind: Ingress":
                break
            else:
                return  False

    with open(filepath, 'w') as f:
        for line in lines:
            f.write("# " + line)
    return True

def uncomment_yaml(filepath):
    with open(filepath, 'r') as f:
        lines = f.readlines()

    with open(filepath, 'w') as f:
        for line in lines:
            f.write(line[2:])

components = []
all_images = []

for root, dirs, files in os.walk("components"):
    for file in files:
        if file == "kustomization.yaml":
            components += [root]
            break

for component in components:
    print("Updating repo mirrors for", component)
    kustomization = "%s/kustomization.yaml" % component

    with open(kustomization, 'r') as f:
        lines = f.readlines()

    start_token = '{% if repo_mirror is defined %}'
    end_token = '{% endif %}'

    output = []
    in_block = False
    inserted = False
    insert_index = None

    for idx, line in enumerate(lines):
        if start_token in line:
            in_block = True
            insert_index = len(output)  # remember where to insert
            continue
        if end_token in line and in_block:
            in_block = False
            continue
        if not in_block:
            output.append(line)

    # Remove the old repo mirrors from the kustomization.yaml
    with open(kustomization, 'w') as f:
        f.writelines(output)

    # Comment out unnecessary files like ingressed to prevent formatting errors
    # because of missing ansible variables (eg {{ var }})
    commented = []
    for root, dirs, files in os.walk(component):
        for file in files:
            if file.endswith((".yaml", ".yml")):
                full_path = os.path.join(root, file)
                if comment_yaml_if_ingress(full_path):
                    commented += [full_path]

    images = []
    for imageStrings in os.popen("kubectl kustomize --enable-helm %s" % component).read().split('\n'):
        if "image:" in imageStrings:
            image = re.search(pattern=r'image: (.+)$', string=imageStrings)
            if image is not None:
                images.append(image.groups()[0])
    images = list(dict.fromkeys(images))

    # Revert comments
    for file in commented:
        uncomment_yaml(file)

    new_lines = ['{% if repo_mirror is defined %}\n', 'images:\n']

    for i in images:
        # make additional kustomization.yaml definitions
        new_lines += ["- name: %s\n" % (i)]
        # special case for silly library shortcuts
        if not '/' in i:
            i = "docker.io/library/" + i
        # 2nd case if we don't have a registry host in front
        firstElement = i.split('/')[0]
        if not '.' in firstElement:
            i = "docker.io/" + i
        # and now lets check if we have versions or digest
        if ':' in i:
            (ima, tag) = i.split(':')
            outTag = "  newTag: %s" % tag
        else:
            if '@' in i:
                (ima, digest) = i.split('@')
                outTag = "  digest: %s" % digest
            else:
                ima = i
                outTag = "  newTag: latest"
        new_lines += ["  newName: {{ repo_mirror }}/%s\n" % (ima)]
        new_lines += [outTag + "\n"]
        if ima == i:
            i = ima + ':latest'
        all_images += ["%s,__REPOMIRROR__/%s\n" % (i, i)]
        
    new_lines += ['{% endif %}\n']

    # Insert new lines
    if insert_index is not None:
        output[insert_index:insert_index] = new_lines
        inserted = True
    else:
        output.extend(["\n"]+new_lines)

    # Write the updated content back
    with open(kustomization, 'w') as f:
        f.writelines(output)

print("Collecting kubernetes image list")
if not shutil.which("kubeadm"):
    print("Error! kubeadm not found in PATH.")
    print("Please install it to get the final image list")
    exit(1)

with open("cluster-template/inventory.yaml", 'r') as f:
    data = yaml.safe_load(f)

k8s_version = data['all']['vars']['k8s_version']

kubeadm_cmd = ["kubeadm", "config", "images", "list", f"--kubernetes-version={k8s_version}"]
try:
    result = subprocess.run(kubeadm_cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True, text=True)
    images = result.stdout.strip().splitlines()

    images = [f"{img},__REPOMIRROR__/{img}\n" for img in images]

    images = [
        img.replace("__REPOMIRROR__/registry.k8s.io/coredns/coredns:", "__REPOMIRROR__/registry.k8s.io/coredns:") if "__REPOMIRROR__/registry.k8s.io/coredns/coredns:" in img else img
        for img in images
    ]

    all_images += images
except subprocess.CalledProcessError as e:
    print(f"Failed to run kubeadm: {e.stderr.strip()}")
    exit(1)


print("Writing final image list")
with open("imagelist.csv", 'w') as f:
    f.writelines(list(dict.fromkeys(all_images)))