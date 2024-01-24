# Automation for ProxMox

- Take the `./vm-env-example.sh` and copy it to your repo
- Edit it:

  - servers= "pairs of servername:proxmox-id separated by spaces"
  - mynet= "IP prefix of my network"
  - domain= "domain of the servers beginning with ."
  - qm= "alias for the qm command. Typically an ssh cmd"

- Now you can use the 6 commands to control your rollout!