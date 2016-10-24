#!/bin/bash
# 2016-10-20 09:47:32  pflint
# builds trantor from the ~/trantor/doc directory
#
# 
rm -rf test;  
sphinx-build -b html ./ test ; 
sed -i 's/><img/ target="_blank" ><img/g' test/index.html
firefox test/index.html
