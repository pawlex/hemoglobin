#!/bin/bash

## This file will outline how to set up Samba
## Which uses the CIFS protocol to create file-shares
## visible to Windows.

# install samba package
yum install samba

# stop services
/etc/init.d/smb stop # SMB/CIFS server
/etc/init.d/nmb stop # NetBIOS name server

# back up original config file
cd /etc/samba
mv smb.conf smb.conf.orig

# create a group for samba users.  helpful for managing file permissions
groupadd smbusers

# Add your user to both groups.  
# Cindy should probably only be part of the smbusers group
usermod -aG smbadmins greg
usermod -aG smbusers greg
usermod -aG smbusers cindy

# add a samba password for the users of the system
# I like to make this the same as my windows password.
# you have a windows password, RIGHT?!?!
smbpasswd -a greg

# create a root for your smb storage.
# I like to make a folder on my raid array
# for items that are unique to the local machine
# with the name as the hostname of the local machine
# !!this is optional and my preference.
mkdir /mnt/STORAGE/hemoglobin

# I like to have a private Personal_Folders share
# mapped to the windows user who is logging in.
mkdir /mnt/STORAGE/Personal_Folders

# I like to put hard mounts in /mnt
# and soft mounts + links to hard mounts
# in /media
ln -s /mnt/STORAGE/hemoglobin /media/hemoglobin
ln -s /mnt/STORAGE/Personal_Folders /media/Personal_Folders

# create new config file
cat > smb.conf

