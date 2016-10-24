#!/bin/bash
# 2016-09-23 07:44:122016-10-18  pflint
# duplicates an rst file with new number
#
# 
# must also write into index.rst
#
echo "Wrote "$1".rst"
cat ./154.rst | sed 's/154/'"$1"'/g' > $1.rst
