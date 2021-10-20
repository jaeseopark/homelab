#!/bin/bash -ex

FILENAME="2021-05-10-raspios-buster-armhf-lite-cloud-init.zip"
IMG_URL="https://github.com/timebertt/pi-cloud-init/releases/download/2021-05-10/${FILENAME}"
CUSTOM_HOSTNAME=${1}

if [[ "${EUID}" -ne "0" ]]; then
   echo "This script must be run as root" 
   exit 1
fi

apt-get install unzip # if not already installed

download_image() {
    rm -f *.img
    if [ ! -f ${FILENAME} ]; then
        wget ${IMG_URL}
    fi
    unzip *.zip
}

mount_image() {
    UNIT_BYTES=512 # double check by running: fdisk -l *.img
    partition_start=$(fdisk -l *.img | grep FAT | awk '{print $2}')
    offset=$((partition_start*UNIT_BYTES))
    mkdir /mnt/tmp/rpibootdisk -p
    mount -o loop,offset=${offset} *.img /mnt/tmp/rpibootdisk
}

copy_files_to_mounted_volume() {
    git status
    if [ "$?" -eq "0" ]; then
        # I am already in the git tree
        cp ../cloud-init/* /mnt/tmp/rpibootdisk
    else
        git clone https://github.com/jaeseopark/homelab.git
        cp ./homelab/bootstrap/cloud-init/* /mnt/tmp/rpibootdisk
        rm -rf ./homelab
    fi
    if [ ! -z ${CUSTOM_HOSTNAME} ]; then
        sed -i "s/newbox/${CUSTOM_HOSTNAME}/" /mnt/tmp/rpibootdisk/user-data.yaml
    fi
}

apply_rpi_specific_settings() {
    pip3 install pyyaml
    ./append_startup_files.py /mnt/tmp/rpibootdisk/user-data.yaml
}

download_image
mount_image
copy_files_to_mounted_volume
apply_rpi_specific_settings
umount /mnt/tmp/rpibootdisk

echo "------------------------------------------"
echo "Image is ready: $(ls *.img)"
