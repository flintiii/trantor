#!/bin/bash
# 2016-10-18 10:14:04 pflint
# checks to see if rst file is sane
#
clear
wd="/home/flint/trantor/doc"
pd="/home/flint/catalog/pix"
sd=
# 
# if [ -f exists.file ] ; then echo "yes" ; else echo "no" ; fi
# must also write into index.rst
#
echo "check for rst file in ""$wd"
ls $wd |grep $1
#
# echo "Wrote "$1".rst"
# cat ./154.rst | sed 's/154/'"$1"'/g' > $1.rst
#
echo "check for f&b files in ""$pd"
ls $pd |grep $1
#
echo "check for references in ""$wd""/"index.rst
cat $wd"/"index.rst | grep $1 
#
echo "Is LXFDVD"$1".iso in the repository?"
# wget --spider --force-html http://bigdelllap/test/cd/LXFDVD$1/index.html
wget --spider http://bigdelllap/test/cd/LXFDVD$1/index.html  2>&1 >/dev/null | grep -A1 'Length:'
#

