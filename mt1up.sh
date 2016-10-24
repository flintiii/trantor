#!/bin/bash
# 2016-09-23 07:44:12 pflint
# mounts the one USB as a drive
#
# Must be run as root
#
echo "Mounting $1 as part of site"
sudo mount -t iso9660 "/media/flint/Seagate Replica/lxfdvd/$1.iso" /home/flint/trantor/doc/test/cd/$1
echo "See this is mounted"
df -h | grep $1

