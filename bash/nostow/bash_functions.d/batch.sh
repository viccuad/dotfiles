# Execute a given Linux command on a group of files
# Example: batchexec sh ls		# lists all files that have the extension 'sh'
# Example: batchexec sh chmod 755	# 'chmod 755' all files that have the extension 'sh'
function batchexec()
{
find . -type f -iname '*.'${1}'' -exec ${@:2}  {} \; ;
}
