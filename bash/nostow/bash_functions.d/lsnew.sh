# List the most recent files in a directory
lsnew()
{
	ls -lt ${1+"$@"} | head -20;
}
