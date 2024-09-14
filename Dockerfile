ARG CEPH_VERSION

FROM quay.io/ceph/ceph:v${CEPH_VERSION}

COPY patches /cdalvaro_patches
RUN python3 /cdalvaro_patches/allow_usb_devices.py
