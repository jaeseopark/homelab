## Control Node

1. Install ansible. See [Installation Guide](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html). TLDR, for most distros:
    ```bash
    pip install ansible
    ```
1. Copy the public key into this folder:
    ```bash
    cp ~/.ssh/id_rsa.pub .
    ```
1. Use ansible:
    ```bash
    ansible ...args -i inventory.ini
    ```
