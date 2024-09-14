#!/usr/bin/env python3

"""
Sources for the patch:
  - https://github.com/ceph/ceph/pull/49954
  - https://github.com/rook/rook/issues/14699
"""

import os
import re
import pkg_resources

PKG_NAME = "ceph_volume"
CEPH_PACKAGE = pkg_resources.resource_filename(PKG_NAME, "")
if not os.path.isdir(CEPH_PACKAGE):
    raise FileNotFoundError(f"The {PKG_NAME} package does not exist")

DEVICE_RESOURCE = os.path.join(CEPH_PACKAGE, "util", "device.py")
if not os.path.isfile(DEVICE_RESOURCE):
    raise FileNotFoundError(f"The {DEVICE_RESOURCE} file does not exist")

with open(DEVICE_RESOURCE, "r", encoding="utf-8") as f:
    file_contents = f.read()

SEARCH_PATTERN = r"(.*\('id_bus', 'usb', 'id_bus'\),.*)"
patched_contents = re.sub(SEARCH_PATTERN, r"# \1", file_contents, flags=re.MULTILINE)
if file_contents == patched_contents:
    raise ValueError("The patch was not applied")

with open(DEVICE_RESOURCE, "w", encoding="utf-8") as f:
    f.write(patched_contents)

print("The 'allow_usb_device' patch was successfully applied\n")
