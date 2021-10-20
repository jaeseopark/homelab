## Headless Image Setup w/ cloud-init

https://github.com/timebertt/pi-cloud-init

### Features

Everything in [cloud-init](../cloud-init/), plus:

1. Disables built-in LED's
1. Installs:
    |Name|Version|
    |---|---|
    |git| |
    |pip| |
    |venv| |

The goal is to bring parity with the [Debian netinst image](https://www.debian.org/CD/netinst/), so the rest of the config can be done by Ansible.

### Requirements

As tested with: Debian 5.10.46-4 (2021-08-03) x86_64

* `apt-get`
* `python3` and `pip3`

### Usage

1. Prep the image
    ```bash
    sudo ./prep_image.sh [hostname] # default hostname: newbox
    # ... Image is ready: 2021-05-10-raspios-buster-armhf-lite-cloud-init.img
    ```
1. Insert the SD card and make note of its device name
    ```bash
    sudo fdisk -l | grep SANDISK
    # ... /dev/sdb
    ```
1. Write data to the SD card
    ```bash
    dd if=*.img of=/dev/sdb
    ```
