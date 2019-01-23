#!/bin/bash

# RAID SETUP FOR HOMOGOBLIN
# PK

# zero the HDD's
dd if=/dev/zero bs=1M count=128 of=/dev/sdb
dd if=/dev/zero bs=1M count=128 of=/dev/sdc
dd if=/dev/zero bs=1M count=128 of=/dev/sdd
dd if=/dev/zero bs=1M count=128 of=/dev/sde

# create the partition tables on the HDD's
parted --script /dev/sdb mklabel gpt mkpart RAID ext2 1M 100%
parted --script /dev/sdc mklabel gpt mkpart RAID ext2 1M 100%
parted --script /dev/sdd mklabel gpt mkpart RAID ext2 1M 100%
parted --script /dev/sde mklabel gpt mkpart RAID ext2 1M 100%

# create the raid
mdadm --create md0 -l 5 -n 4 -c 1024 /dev/sdb1 /dev/sdd1 /dev/sde1 /dev/sdc1

# check raid status
cat /proc/mdstat

# create mdadm.conf
mdadm --detail --scan > /etc/mdadm.conf

# initialize raid device as LVM as a physical volume
pvcreate /dev/md127

# create logicel volume group (called STORAGE)
vgcreate -s 16M STORAGE /dev/md127

# create logical volume (called V0)
lvcreate -l 100%free -n V0 STORAGE

# create filesystem on logical volume (with a label called storage)
mkfs.xfs -L STORAGE /dev/STORAGE/V0

# add filesystem to /etc/fstab (filesystem table)
# use blkid to get the UUID of the filesystem.
UUID=edbd2d4a-7143-4aa0-8e33-72bbda68ba45       /mnt/STORAGE    xfs     defaults,noatime,nodiratime,noexec,nofail       0 2

# Create mount location
mkdir -p /mnt/STORAGE

# mount the filesystem for the 1st time manually.
mount /mnt/STORAGE
