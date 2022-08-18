Description:

This script was created in order to provision a template for Proxmox, based on the Ubuntu 22.04 LTS (Cloud - Init) img.

The code uses the concept of functions a lot, which allows us to, at the end of this, put what will be the order of execution of the same.

Code segmented into stages, each with its description and functions, to facilitate reading, understanding, and future code maintenance.

Requirements:

1 - Proxmox Hypervisor Server.
2 - Shell Acess.

Execute:

Download and run script. "Sh" and "Curl".
sh -c "$(curl -fsSL https://github.com/Xiatsus/Proxmox/blob/main/ubuntu-cloud-init.sh)"