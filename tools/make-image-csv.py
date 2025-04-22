#! env python3
# Hacked together by peter@pflaeging.net

import os, argparse, textwrap, re

kubectlCmd = "kubectl kustomize --enable-helm "
directory = "."
imageList = "imagelist.csv"
kustomizeAdd = "kustomization-add.yaml"

images = []
for imageStrings in os.popen(kubectlCmd + directory).read().split('\n'):
    if "image:" in imageStrings:
        image = re.search(pattern=r'image: (.+)$', string=imageStrings)
        if image is not None:
            images.append(image.groups()[0])

imageListFile = open(imageList, mode='w')
kustomizeAddFile = open(kustomizeAdd, mode='w')

print('{% if repo_mirror is defined %}\nimages:', file=kustomizeAddFile)

for i in images:
    # make additional kustomization.yaml definitions
    print("- name: %s" % (i), file=kustomizeAddFile)
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
    print("  newName: {{ repo_mirror }}/%s" % (ima), file=kustomizeAddFile)
    print(outTag, file=kustomizeAddFile)
    if ima == i:
        i = ima + ':latest'
    print("%s,__REPOMIRROR__/%s" % (i, i), file=imageListFile)
    
print('{% endif %}', file=kustomizeAddFile)

exit