#!/bin/bash
# 2016-09-23 07:44:12 pflint
# unmounts the lxf DVDs 
#
# Must be run as root
#
df -h | grep loop |cut -c -15 |while read line; do echo $line; done
df -h | grep loop |cut -c -15 |while read line; do umount $line; done
df -h | grep loop |cut -c -15 |while read line; do echo $line; done
