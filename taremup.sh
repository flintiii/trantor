#!/bin/bash
# 2016-09-23 07:44:12 pflint
# mounts the big USB drive
#
# Must be run as root
#
~flint/trantor/bin/umntem.sh # unmounts the freakin cds
tar -zcvf ~/seltzer_trantor.gz ~flint/trantor
tar -zcvf ~/seltzer_catalog.gz ~flint/catalog
~flint/trantor/bin/mntemup.sh # re-mounts the cds

