## Headless Image Setup w/ cloud-init

https://github.com/timebertt/pi-cloud-init

|Control Node|Target Node|
|---|---|
|Debian 5.10.46-4 (2021-08-03) x86_64|Model 4 B Rev 1.4|

### Steps

1. Prepare the programs
    ```bash
    which fdisk # maybe in /sbin
    sudo apt-get install unzip # if not already installed
    ```
1. Download then unzip the image
    ```bash
    IMG_URL=https://github.com/timebertt/pi-cloud-init/releases/download/2021-05-10/2021-05-10-raspios-buster-armhf-lite-cloud-init.zip 
    wget ${IMG_URL} && unzip *.zip
    ```
1. Mount the partition and copy the init files over
    ```bash
    UNIT_BYTES=512 # double check by running: /sbin/fdisk -l *.img
    PARTITION_START=$(/sbin/fdisk -l *.img | grep FAT|awk '{print $2}')
    OFFSET=$((PARTITION_START*UNIT_BYTES))
    sudo mkdir /mnt/tmp -p
    sudo mount -o loop,offset=${OFFSET} *.img /mnt/tmp
    cp init/* /mnt/tmp/
    ```
1. Unmount the volume
    ```bash
    sudo umount /mnt/tmp
    ```
1. Burn the image
    TBD
