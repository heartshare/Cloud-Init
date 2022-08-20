#!/bin/bash
#
#
## This script was created in order to provision a template for Proxmox, based on the Ubuntu 22.04 LTS (Cloud - Init) img.
#
#
## The code uses the concept of functions a lot, which allows us to, at the end of this, put what will be the order of execution of the same.
#
#
## Code segmented into stages, each with its description and functions, to facilitate reading, understanding, and future code maintenance.
#
#
## Author: Adson Almeida.


## --------------------------------------  Variables. --------------------------------------##

## APT_PACKAGES. ##
SOFTWARE_NAME="cloud-init"

## Link(s): ##
UBUNTU_CLOUD_INIT_IMG="https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"

## Folder: ##
DOWNLOADS_DIRECTORY="$HOME/Downloads/"

## --------------------------------- Personal Details. ------------------------------------ ##

## Info about the user and computer. ##
echo "Your username is:"
whoami

echo "Current time info and time the computer is on:"
uptime

echo "The script will run in the root directory.:"
cd || { echo "Cd command failed."; exit 1; }
pwd

## Symbolic Colors. ##
BIRed='\e[1;91m'
BIGre='\e[1;92m'
RCol='\e[0m'

## Updating repositories. ##
apt_update(){
   apt update -y && apt dist-upgrade -y
}

## ---------------------------------------- Tests. ---------------------------------------- ##

## Connectivity Test. ##
##   Cloudflare DNS.  ##

internet_test(){
if ! ping -c 4 1.1.1.1 -q &> /dev/null; then
  echo -e "${BIRed}[ERROR] - No Internet Connection.${RCol}"
  exit 1
else
  echo -e "${BIGre}[INFO] - Internet connected.${RCol}"
fi
}

## --------------------------------------------------------------------------------------- ##

## Apt Test. ##
## In case of malfunction of Apt. ##
apt_broken(){
  rm /var/lib/dpkg/lock-frontend
  rm /var/cache/apt/archives/lock
  dpkg --configure -a
}

## Updating repositories again. ##
updating_repositories(){
 apt update -y
}

## ---------------------------------- Installation. -------------------------------------- ##

## Apt Install - Cloud Init In The Case. ##
install_deb(){

echo -e "${BIGre}[INFO] - Installing packages through apt.${RCol}"

apt install "$SOFTWARE_NAME" -y
# apt install "II"
# apt install "III"
echo "[Installed] - $SOFTWARE_NAME"

}

## --------------------------------------------------------------------------------------- ##

## Download and configure Cloud Init Proxmox Template. ##
install_software(){

echo -e "${BIGre}[INFO] - Downloading Image Ubuntu 22.04.${RCol}"

mkdir "$DOWNLOADS_DIRECTORY"
wget -c "$UBUNTU_CLOUD_INIT_IMG"       -P "$DOWNLOADS_DIRECTORY"

## Img Config. ##

## Create a new VM. ##
qm create 9000 --name "ubuntu-22.04-cloudinit-template" --memory 2048 --net0 virtio,bridge=vmbr0

## Import the downloaded disk to local-lvm storage. ##
qm importdisk 9000 jammy-server-cloudimg-amd64.img local-lvm

## Finally attach the new disk to the VM as scsi drive. ##
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-1

## Add Cloud-Init CD-ROM drive. ##

## The next step is to configure a CD-ROM drive, which will be used to pass the Cloud-Init data to the VM. ##
qm set 9000 --ide2 local-lvm:cloudinit

## To be able to boot directly from the Cloud-Init image, set the bootdisk parameter to scsi0, and restrict BIOS to boot from disk only. This will speed up booting, because VM BIOS skips the testing for a bootable CD-ROM. ##
qm set 9000 --boot c --bootdisk scsi0

## Also configure a serial console and use it as a display. Many Cloud-Init images rely on this, as it is an requirement for OpenStack images. ##
qm set 9000 --serial0 socket --vga serial0

## In a last step, it is helpful to convert the VM into a template. From this template you can then quickly create linked clones. The deployment from VM templates is much faster than creating a full clone (copy). ##
qm template 9000

}

## ------------------------------- Post Installation. --------------------------------- ##


## Updating and cleaning. ##
system_clean(){

apt update -y
apt autoclean -y
apt autoremove -y
}

## --------------------------------- Execution Order. ---------------------------------- ##

internet_test
apt_broken
apt_update
apt_broken
updating_repositories
install_deb
install_software
apt_update
system_clean

## ---------------------------------- Finalization. ----------------------------------- ##

echo -e "${BIGre}[INFO] - Cloud Init installed. Ubuntu 22.04 template created. :)${RCol}"
echo -e "${BIGre}[INFO] - The task was finished, the next step will be the provisioning of Vm's with Terraform. :)${RCol}"
