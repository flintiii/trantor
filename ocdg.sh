#!/bin/bash
# pflint Mon 18 Nov 2014 10:58:26 AM EST
# add checking...Mon 24 Nov 2014 10:24:46 AM EST   
# need to add default name
# 
# the Old CD Game
version="0.3"
modified="09/04/2015" 
#
# next lines run ballisticly
#* hold environment
S=$PWD
# echo "This is the path "$S
#
#* check location of vital files and programs, sanity check
for prog in curl gawk isoinfo hal-find-by-capability hal-find-by-property beep # debug banana
do
# echo $prog
isit=$(which $prog)
# echo $isit 
if [ ! -f "$isit" ]
then
    echo "the file $prog is not on system"
    exit 0
fi
done
#
# Define files to be used
# 
# qualify user
# uid="" ; if [ "$uid" == "" ]; then echo "Set user id!"; exit; fi
# passwd="" ; if [ "$passwd" == "" ]; then echo "Set user passwd!"; exit; fi
# echo "Check if you are root"
# uroot()
# exit
#
# above runs ballisticly
#
#* function help  - Help function for template basic help goes here
function help(){
clear;
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version; uroot #debug 
cat $0 | grep '^## ' | sed -e 's/##//'
# echo "This is the help function"
##                       *****DOCUMENTATION*****
## Welcome to the Old CD Game...
## You get this when you put in the wrong number or type of arguments...
## The name of this program is ocdg.sh, just a simple gizmo to get around.
## The difficulty of having the dove imap daemon and pine fight. 
## This is released under GPL I
## The syntax is:
##  - ocdg.sh diriso - shows directory of iso files in current directory
##  - ocdg.sh makeiso - makes an iso copy of cd to current directory
##  - ocdg.sh prtcd <filename> - prints a CD DVD of <filename> 
##  - ocdg.sh tst <filename.iso> - tests current CD/DVD 
##    in all of these, Output is delivered to the screen...
##      *** NOTE *** This program must be run as root!
##
## For structure information type "grep '^\#\*' ocdg.sh"
##    :^)
## (C) P Flint, Barre Open Systems Institute Liscensed under GPLI
##
#          *****Documentation Loop ends here the rest is function******
#
} # Test: ocdg.sh
#
#* function dummy - Rename and fill stuff in between braces
function dummy(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
uroot
} # Test:
#
#* function diriso - shows all the iso files in the current directory
function diriso(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
ls | grep iso |xargs ls
} # Test:
#
#* function makeiso - burns an iso image from a CD/DVD  ...
function makeiso(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
clear; echo "this is version "$version
name=$(isoinfo -d -i /dev/cdrom | grep -i "volume id" | cut -d ":" -f 2 | tr -d " ")
# name="mswin7" # add test and default name here
block=$(isoinfo -d -i /dev/cdrom | grep -i "block size" | cut -d ":" -f 2 | tr -d " ")
START=$(date +%s)
echo "Name of this DVD "$name" and the block size is "$block
# do something
# start your script work here
spause
echo "begin to copy with cat the file "$PWD$"/"$name.iso; cat /dev/cdrom > ./$name.iso
# your function ends here
END=$(date +%s)
DIFF=$(( $END - $START ))
echo "It took $DIFF seconds"
eject /dev/cdrom
} # Test: ~flint/bin/ocdg.sh makeiso 
#
#* function tst - tests if CD burned ok.
function tst(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
lpdir=${var2/.iso/}
echo "This step mounts "$var2" as subdirectory "$lpdir" and copies the directory to the file dskd"
# lvd=$(du -h --max-depth=1 $lpdir |tr -d $lpdir |md5sum|rev | cut -c 3- |rev) 
mkdir $lpdir; mount -o loop $var2 $lpdir # >/dev/null
cd $lpdir; du -h --max-depth=1 > ../dskdir; cd ..
# cd $lpdir
echo "This step mounts the dvd as subdirectory dvd and copies the directory to the file dvddir"
echo "put the "$var2" cd in to test"
isoinfo -d -i /dev/cdrom
# spause
# mkdir dvd; mount /dev/dvd dvd
mkdir dvd; mount /dev/cdrom dvd
cd dvd; du -h --max-depth=1 > ../dvddir; cd ..
echo "This step calculates the checksum"
clear
$(diff dskdir dvddir >/dev/null) || echo "something broke"
$(diff dskdir dvddir >/dev/null) && echo "Copy compares OK"
# spause
echo "unmount and clean up"
umount $lpdir ;rm -rf $lpdir
umount "dvd" ;rm -rf "dvd"
rm -rf dvd $lpdir
eject /dev/cdrom
} # Test:ocdg.sh tst <filename.iso>
#
#* function prtcd - cuts a cd from <ISONAME> iso image...
function prtcd(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
echo "The file name you picked is "$var2
if [ ! -f "$var2" ]; then 
	echo "The File \"$var2\" Does Not Exist nothing can happen"
	return 
fi 
echo "The File $var2 Exists"
echo -n "Put a blank CD in and "
UDI=`hal-find-by-capability --capability storage.cdrom`
device=`hal-get-property --udi $UDI --key block.device`
echo $device
echo "Put a nice shiny new dvd in with at least "$(ls -alt $var2 | cut -d " " -f 5)" of capacity"
spause
wodim dev=$device -v -data $var2
echo "all done.  Write "$var2" on the disk with the sharpie proviced"
eject $device
play /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga 2>/dev/null
} # Test: ocdg.sh tst <filename.iso>
# Fri 21 Nov 2014 09:49:12 AM EST NOTES ON OVERSIZE ISO IMAGES:
# http://gotoanswer.stanford.edu/error_while_burning_dvd_help-4325359/
# 
# ubuntu autolaunch "you have just inserted"
# gnome-control-center &
# applications > media
# http://askubuntu.com/questions/6677/how-do-i-banish-the-you-have-just-inserted-an-audio-cd-dialog-forever
# 
#
#* function uroot - Checks to see if you are root
function uroot(){
# echo "Make sure only root can run script"
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root, restart as root user" 1>&2
   exit 1
fi
} # Test:~flint/bin/ocdg.sh uroot
#
######################################STANDARD AND MAYBE USEFUL FUNCTIONS BELOW
#
#
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
# echo "ocdg.sh v"$version" starts"
#* Evaluator Routine
# Note the evaluator allows for many cases and error checking...
# ARGS=$#         # carries the number of args into the functions...
if [ "$#" -eq "1" ] && [ "$1" = "makeiso" ]; then ARGS="1"; fi
if [ "$#" -eq "1" ] && [ "$1" = "diriso"  ]; then ARGS="1"; fi
if [ "$#" -eq "2" ] && [ "$1" = "prtcd"   ]; then ARGS="2"; fi
if [ "$#" -eq "2" ] && [ "$1" = "tst"     ]; then ARGS="2"; fi
if [ "$#" -eq "1" ] && [ "$1" = "on"      ]; then ARGS="1"; fi
if [ "$#" -eq "1" ] && [ "$1" = "dummy"   ]; then ARGS="1"; fi
if [ "$#" -eq "1" ] && [ "$1" = "uroot"   ]; then ARGS="1"; fi
if [ "$#" -eq "1" ] && [ "$1" = "spause"  ]; then ARGS="1"; fi
if [ "$#" -eq "1" ] && [ "$1" = "help"    ]; then ARGS="9"; fi
# this tests the evaluator...
#debug echo $#"     "$1"    "$2"    "$3"    "$ARGS  
# typical cases, be careful to make your own...
case "$ARGS" in
    "0") clear; $1="help"; exit 1;;			        # got nothing, display help and go
    "1") $1 ;;                                              	# run the command
    "2") var2=$2;  $1 ;;                                    	# run the command with an argument
    "3") var3=$3; var2=$2;  $1 ;;                           	# run the command with two arguments
    "4") var4=$4; var3=$3; var2=$2;  $1 ;;                      # run the command with three arguments
    "5") prompt=$2; $1 ;;				    	# run the command with a different argument
    "6") time=$3; prompt=$2;  $1 ;;				# run the command with two different arguments
    "7") defvbl; $1 ;;						# run the command and default variables
    "8") var2=$2;  $1 ;;                                 	# run the command and settle variables
    "9") var3=$3; var2=$2;  $1 ;;                               # run the command and settle variables
      *) clear; cat $0 | grep '^## '| sed -e 's/##//'; exit 1;; # Anything else run help and exit...
esac # End main loop. To TEST:
#
# echo " ";
echo "On "$(date +%F\ %r) $0" version "$version" stops"
#debug echo  "That's all folks!!"
#
#* restore environment
cd "$S"
