#!/bin/bash
# Fri 28 Oct 2016 11:12:19 AM EDT  
# pflint
# save todays trantor bin into seltzer 
ls -alt --full-time --time-style=long-iso | grep $(date +%F) |cut -c 50- |grep sh |while read line; 
do echo $line; 
scp $line flint@seltzer:./trantor/bin/.; 
done
