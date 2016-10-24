#* function dvd - cuts a cd from <ISONAME> iso image...
function dvd(){
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
} # Test: ocdg.sh dvd <filename.iso>
# Fri 21 Nov 2014 09:49:12 AM EST NOTES ON OVERSIZE ISO IMAGES:
# http://gotoanswer.stanford.edu/error_while_burning_dvd_help-4325359/
# 

