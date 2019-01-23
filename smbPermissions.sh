#!/bin/bash

# File system permissions for SMB setup
cd /mnt/STORAGE

# Change owner to root group to smbusers
chown -R root.smbusers ./Personal_Folders ./hemoglobin
# wipe any permissions
chmod -R 0000 ./Personal_Folders ./hemoglobin
# make user/group read/write/execute (if directory)
chmod ug+rwX ./Personal_Folders ./hemoglobin
# create Personal_Folder/greg
mkdir /mnt/STORAGE/Personal_Folders/greg
chmod 0000 greg; chmod ug+rwX,o+t greg/

