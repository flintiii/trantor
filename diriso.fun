#
#* function diriso - shows all the iso files in the current directory
function diriso(){
echo "This is the \""$FUNCNAME"\" function in "$0" version "$version #debug
ls | grep iso |xargs ls
} # Test:
#
