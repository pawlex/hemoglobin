#!/bin/bash

cd /etc/yum.repos.d/

sed -i.bak 's/^mirrorlist/#mirrorlist/g' ./CentOS-Base.repo
sed -i.bak 's/mirror.centos.org/mirrors.wtcx.org/g' ./CentOS-Base.repo
sed -i.bak 's/^#baseurl/baseurl/g' ./CentOS-Base.repo
