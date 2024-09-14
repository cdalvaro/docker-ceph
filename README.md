# Ceph

<picture align="center">
  <source media="(prefers-color-scheme: dark)" srcset="/media/CephLogoDark@2x.png">
  <source media="(prefers-color-scheme: light)" srcset="/media/CephLogoLight@2x.png">
  <img alt="Ceph logo" src="/media/CephLogoLight@2x.png">
</picture>

This repository is a fork of the original Ceph repository focused on giving support to run Ceph on Raspberry Pi.

## Patches

### Allow USB devices

This patch allows the use of USB devices as OSDs.

![Available Physical Disks](media/AvailablePhysicalDisks@2x.png)

As commented on [rook/rook #14699](https://github.com/rook/rook/issues/14699), USB disks are ignored by Ceph because of `id_bus`.

Since [ceph/ceph #49954](https://github.com/ceph/ceph/pull/49954) Ceph does not allow USB devices to be used as OSDs. This patch reverts the changes made in that PR.

For more information, check the [patch](patches/allow-usb-devices.py).
