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
    ARCH="armhf" # either armhf or aarch64 (experimental)
    FILENAME="2021-05-10-raspios-buster-$ARCH-lite-cloud-init.zip"
    SOURCE_URL="https://github.com/timebertt/pi-cloud-init/releases/download/2021-05-10/${FILENAME}"
    curl -sSL -o ${FILENAME} ${SOURCE_URL} &&  unzip -o ${FILENAME}
    ```
1. Find the boot partition offset
    ```bash
    fdisk -l *.img

    # Sample output:
    Disk 2021-05-10-raspios-buster-armhf-lite-cloud-init.img: 1.76 GiB, 1887436800 bytes, 3686400 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0x60ec0171

    Device                                               Boot  Start     End Sectors  Size Id Type
    2021-05-10-raspios-buster-armhf-lite-cloud-init.img1        8192  532479  524288  256M  c W95 FAT32 (LBA)
    2021-05-10-raspios-buster-armhf-lite-cloud-init.img2      532480 3686399 3153920  1.5G 83 Linux
    ```
    >The FAT partition is offset by 8192 sectors, where each sector is 512 bytes => a total of 4194304 bytes.
1. Mount the partition and copy the init files over
    ```bash
    OFFSET=4194304 # From the previous step
    sudo mkdir /mnt/tmp -p
    sudo mount -o loop,offset=${OFFSET} *.img /mnt/tmp
    cp init/* /mnt/tmp/
    ```
1. Unmount the volume
    ```bash
    sudo umount /mnt/tmp
    ```
