#!/bin/bash
# 08/06/2016 09:59:41 AM pflint
# a program to catalog all the ".iso" files in the LXF DVD collection
# pflint
#
# next lines run ballisticly
#* hold environment
S=$PWD
#D echo "This is the path "$S; spause
# check that you are root
#
# uses a source include
#D source ncdg.shi
#D source bin/testi.shi
#D 
# Indexes LXF DVDs 
# Mounts a DVD
# Puts an ISO on a multiboot 
version="0.010"
#
# location of iso images
sd='/media/flint/Seagate Replica/lxfdvd'
#
#* function help  - Help function for template basic help goes here
function help(){
clear;
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version; uroot #debug 
cat $0 | grep '^## ' | sed -e 's/##//'
# echo "This is the help function"
##                       *****DOCUMENTATION*****
## You get this when you put in the wrong number or type of arguments...
## The name of this program is ctrantor.sh, a tool for managing trantor
## a web server designed to serve out Linux Format DVDs.
##      *** NOTE *** This program need not be run as root,
##      *** BUT! *** Some components require root!
## The syntax is:
## OPERATION
##  - ctrantor.sh diriso - Lists DVD images
##  - ctrantor.sh web [on off] - Turn Web Server on or off 
##  - ctrantor.sh [mount unmount] <FILENAME> - Mounts unmounts iso
##    images from file
##  - ctrantor.sh [dvd usb] <ISO NAME> - makes dvd or usb   
##    in all of these, Output is delivered to the screen...
## MAINTENANCE
##  - ctrantor.sh newiso - Copies new DVD image
##    into repository  
##  - ctrantor.sh nuweb - builds new web site from files 
##  - ctrantor.sh impjpg [ISONAMEf.jpg ISONAMEb.jpg] - 
##    places jpg images of cover  
##    (front or back) into repository  
##  - ctrantor.sh potrite - checks to see if all 
##    components are there and where they should be
##  - ctrantor.sh county - Lists included scripts & functions 
## INSTALLATION
##  - ctrantor.sh sane - Checks platform to  
##    determine if all components are abailable  
##    if root offers to install missing parts.  
##  - ctrantor.sh setup <URL NAME> setup trantor  
##    if root.  
##    :^)
## (C) P Flint, Barre Open Systems Institute Liscensed under GPLI
## This is released under GPL dbtsI
##
} # Test:
#
#          *****Documentation Loop ends here the rest is function******
#
#
#* function dummy - Rename and fill stuff in between braces
function dummy(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
uroot
} # Test:
#
#* function include - loads files with additioal functions not particularly a menu item.
function include(){
#D echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
#D echo "This is the path "$S; 
#D echo "This is \$0 "$0
fname=$1
#D echo "Include "$fname
incp=""$(echo $0 |rev | cut -d"/" -f 2- |rev)"/"
incf=$incp$fname
#D echo "This is the sourced file "$incf
source $incf
bsm+=("${BASH_SOURCE[@]}") # add current source file to variable
#D echo "The current bash source array is:"${bsm[@]}
#D echo $incf
#D echo ${BASH_SOURCE[@]}
} # Test:
#
# This loads the next section of the code...
include testi.shi
include dvdio.shi
#D echo "The current bash source array is:"${bsm[@]}
#
#* function mtdvd - Mounts DVD 
function mtdvd(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
uroot
#
target=LXFDVD211.iso
# check that "/mnt/disk" exists, if not make it.
dir="/mnt/disk"
if [[ ! -e $dir ]]; then
    mkdir $dir
elif [[ ! -d $dir ]]; then
    echo "$dir already exists but is not a directory" 1>&2
fi
# files are stored in "/lxfdvd"
# Mount first DVD entry in array as a loopback
# mkdir -p /mnt/disk
mount -o loop $target /mnt/disk
#
} # Test:
#
#
#* function showdvd - shows you what is on the mounted dvd
function showdvd(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
# uroot
# ls -1 | grep LXFDVD | sort -n | less
ls -1 | grep LXFDVD | sort -n |while read line; 
do 
	echo $line; 
	mount $target $dir
done
# Search mounted DVD loopback for ".iso$"
find $dir  | grep iso$
} # Test:
#
# Read directory into text array
#
#* function umtdvd - Unmounts the DVD
function umtdvd(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
uroot
# Unmount DVD loopback
umount $dir/$target
} # Test: 
#
#* check location of vital files and programs, sanity check
function sane(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
uroot
rm -rf need > /dev/null
for prog in sphinx git pv apache2  # programs you need put here
do
	# echo $prog
	isit=$(which $prog)
	# echo $isit 
	if [ ! -f "$isit" ];
	then
	    echo $prog >> need
	    #debug echo "Type \"sudo apt-get install $prog\" to fix this."
	    #debug spause
	    # exit 0
	fi
done
clear
echo "Welcome to $0!"
echo "Missing programs:"
	if [ -f need ];
	then
	   echo "    This program needs the following program(s) to be installed on this system."
	   cat need |while read line; do echo -e \\t" - " $line; done
	   echo "    If you want them installed please logon as root (sudo $0) and they will install"
	   exit 0 # breaks you out of loop...
	else
	   echo " * None *  Looks like the pot's right, lets play!"
	fi
#
echo "end of check"
} # Test: ctrantor.sh sane
#
#* function setup - setup trantor
function setup(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
uroot
} # Test: ctrantor.sh
#
#* function newiso - Copies new CD image into repository
function newiso(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
uroot
} # Test: ctrantor.sh
#* function nuweb - builds new web site from files
function nuweb(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
uroot
} # Test: ctrantor.sh
#
#* function impjpg [ISONAMEf.jpg ISONAMEb.jpg] places front and back jpgs in web site
function impjpg(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
uroot
} # Test: ctrantor.sh
#
#* function potrite - checks to see if all web and iso components are correct
function potrite(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
uroot
} # Test: ctrantor.sh
#
#* function web - Turn Web Server on 
function webon(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
uroot
} # Test: ctrantor.sh
#
#* function weboff - Turn Web Server  off 
function weboff(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
uroot
} # Test: ctrantor.sh
#
#* function mount <FILENAME> - Mounts iso images in <FILENAME> 
function mount(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
uroot
} # Test: ctrantor.sh
#
#* function unmount <FILENAME> - Unmounts iso images in <FILENAME> 
function unmount(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
uroot
} # Test: ctrantor.sh
#
#* function dvd - makes dvd from <ISONAME>
function dvd(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
uroot
} # Test: ctrantor.sh
#
#* function usb - makes usb from <ISONAME>
function usb(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
uroot # check if you are root.
#D isusb # figure out the usb device
#D sd='/media/flint/Seagate Replica/lxfdvd'
sfap="$sd""/"$var2".iso"
echo "The source path and file is "$sfap
#D 
device="/dev/sdc"
echo "The destination device is "$device
echo -n "If this is not right hit <ctl>c.  If this is OK "
# Here is the way out...
spause
#Note  Sending a USR1 signal to a running `dd' process makes it print I/O statistics 
# to standard error and then resume copying.
#
#              $ dd if=/dev/zero of=/dev/null& pid=$!
#              $ kill -USR1 $pid; sleep 1; kill $pid
# Using pipe view (pv
#              sudo dd if=/dev/sdb | pv -s 2G | dd of=DriveCopy1.dd bs=4096
#
echo "OK we are gonna do it! Figure about 20 minutes for a single usb to DVD conversion"
# time dd bs=4M if="$sfap" of=$device
# time dd if="$sfap" | pv -s 4700M |dd of=$device bs=4M 
time dd if="$sfap" | pv -s 4380M |dd of=$device bs=4M 
#
echo  "That's all folks!!"
} # Test: ctrantor.sh usb
#
#* function isusb - figures out usb device name check if the device is there...
function isusb(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
device="/dev/"$(dmesg | grep mmc |grep GiB |tail -1 |cut -c 15- | cut -d ":" -f 1|tr -d " ")
echo "The USB device is: "$device
}
#
#
######################################STANDARD AND MAYBE USEFUL FUNCTIONS BELOW
#
#
#* function uroot - Checks to see if you are root
function uroot(){
# echo "Make sure only root can run script"
if [ "$(id -u)" != "0" ]; then
   echo "This script needs to run as root and you are not root" 1>&2
fi
} # Test:~flint/bin/ctrantor.sh uroot
#
#* function spause   - A simple tarry...
function spause(){
   # -t sets time
   # read -t $pt -p "$*" ans
   read -p "Hit enter to continue..." ans
   echo $ans
}
#
#*###################################### MAIN ENTRY POINT AND COMPOUND CASE
#
#D include
#
#* Evaluator Routine
# Note the evaluator allows for many cases and error checking...
#d ARGS=$#         # carries the number of args into the functions...
#d echo "Arg# = "$#"  \$1 = "$1"  \$2 = "$2" \$3 = "$3" \$ARGS = "$ARGS ;spause 
#
if [ "$#" -eq "4" ] && [ "$1" = "sets"     ]; then ARGS="4"; fi
if [ "$#" -eq "1" ] && [ "$1" = "shows"    ]; then ARGS="1"; fi
if [ "$#" -eq "2" ] && [ "$1" = "suck"     ]; then ARGS="2"; fi
if [ "$#" -eq "2" ] && [ "$1" = "gdtml"    ]; then ARGS="2"; fi
if [ "$#" -eq "2" ] && [ "$1" = "find"     ]; then ARGS="2"; fi
if [ "$#" -eq "2" ] && [ "$1" = "doit"     ]; then ARGS="2"; fi
if [ "$#" -eq "2" ] && [ "$1" = "find"     ]; then ARGS="2"; fi
if [ "$#" -eq "1" ] && [ "$1" = "isusb"    ]; then ARGS="1"; fi
if [ "$#" -eq "2" ] && [ "$1" = "cut"      ]; then ARGS="2"; fi
if [ "$#" -eq "2" ] && [ "$1" = "cover"    ]; then ARGS="2"; fi
if [ "$#" -eq "1" ] && [ "$1" = "sane"     ]; then ARGS="1"; fi
if [ "$#" -eq "2" ] && [ "$1" = "setup"    ]; then ARGS="2"; fi
if [ "$#" -eq "2" ] && [ "$1" = "newiso"   ]; then ARGS="2"; fi
if [ "$#" -eq "2" ] && [ "$1" = "nuweb"    ]; then ARGS="2"; fi
if [ "$#" -eq "2" ] && [ "$1" = "impjpg"   ]; then ARGS="2"; fi
if [ "$#" -eq "2" ] && [ "$1" = "potrite"  ]; then ARGS="2"; fi
if [ "$#" -eq "2" ] && [ "$1" = "webon"    ]; then ARGS="2"; fi
if [ "$#" -eq "2" ] && [ "$1" = "weboff"   ]; then ARGS="2"; fi
if [ "$#" -eq "2" ] && [ "$1" = "mount"    ]; then ARGS="2"; fi
if [ "$#" -eq "2" ] && [ "$1" = "unmount"  ]; then ARGS="2"; fi
if [ "$#" -eq "1" ] && [ "$1" = "dvd"      ]; then ARGS="1"; fi
if [ "$#" -eq "2" ] && [ "$1" = "usb"      ]; then ARGS="2"; fi
if [ "$#" -eq "1" ] && [ "$1" = "include"  ]; then ARGS="1"; fi
if [ "$#" -eq "1" ] && [ "$1" = "diriso"   ]; then ARGS="1"; fi
if [ "$#" -eq "1" ] && [ "$1" = "summy"    ]; then ARGS="1"; fi
if [ "$#" -eq "2" ] && [ "$1" = "tummy"    ]; then ARGS="2"; fi
if [ "$#" -eq "1" ] && [ "$1" = "county"   ]; then ARGS="1"; fi
if [ "$#" -eq "1" ] && [ "$1" = "dummy"    ]; then ARGS="1"; fi
if [ "$#" -eq "1" ] && [ "$1" = "uroot"    ]; then ARGS="1"; fi
if [ "$#" -eq "1" ] && [ "$1" = "spause"   ]; then ARGS="1"; fi
if [ "$#" -eq "1" ] && [ "$1" = "help"     ]; then ARGS="0"; fi
if [ "$#" -eq "0" ]; then ARGS="0"; fi
# this tests the evaluator...
#d echo "Arg# = "$#"  \$1 = "$1"  \$2 = "$2" \$3 = "$3" \$ARGS = "$ARGS ;spause 
#d echo "ctrantor.sh v"$version" starts" ;spause()
# typical cases, be careful to make your own...
case "$ARGS" in
    "0") clear; "help";;				 	# got nothing, display help and go
    "1") $1 ;;                                              	# run the command
    "2") var2=$2;  $1 ;;                                    	# run the command pass an argument
    "3") var3=$3; var2=$2;  $1 ;;                           	# run the command pass two arguments
    "4") var4=$4; var3=$3; var2=$2;  $1 ;;                      # run the command pass three arguments
    "5") prompt=$2; $1 ;;				    	# run the command with a different argument
    "6") time=$3; prompt=$2;  $1 ;;				# run the command with two different arguments
    "7") defvbl; $1 ;;						# run the command and default variables
    "8") var2=$2;  $1 ;;                                 	# run the command and settle variables
    "9") var3=$3; var2=$2;  $1 ;;                               # run the command and settle variables
      *) clear; "help"; exit 1;;				        # got nothing, display help and go
      # *) clear; cat $0 | grep '^## '| sed -e 's/##//'; exit 1;; # Anything else run help and exit...
esac # End main loop. To TEST:
#
# echo " ";
#f echo "On "$(date +%F\ %r) $0" version "$version" stops"
#debug 
#f echo  "That's all folks!!"
#
#d rm -rf ss # removes super secret data file
#* restore environment
#f cd "$S"
#f echo "ping"

