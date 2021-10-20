#!/usr/bin/env python3

import sys

import yaml

SCRIPT_CONTENT="""
#!/bin/bash

"""

def main():
    yaml_path = sys.argv[1]

    with open(yaml_path) as fp:
        user_data = yaml.safe_load(fp)

    user_data["write_files"].append({
        "path": "/var/lib/cloud/scripts/per-once/02-rpi-specific.sh",
        "permissions": "0744",
        "content": SCRIPT_CONTENT
    })

    with open(yaml_path, "w") as fp:
        yaml.safe_dump(user_data, fp)

if __name__ == '__main__':
    main()
