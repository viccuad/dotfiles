# Extundelete stuff from ext3/ext4 filesystems	
alias extundelete-d='sudo extundelete "$1" --restore-directory "$2"'		# restore all files possible from specified dir.  ("$2" = path/to/directory)
alias extundelete-f='sudo extundelete "$1" --restore-files "$2"'		# restore list of files (use to restore single file) ("$2" = filename)
alias extundelete-r='sudo extundelete "$1" --restore-all'			# restore all files possible to undelete
alias extundelete-sda='sudo extundelete /dev/sda --restore-all'			# restore all files possible to undelete
alias extundelete-sda-d='sudo extundelete /dev/sda --restore-directory "$1"'	# restore all files possible from specified dir.  ("$1" = path/to/directory)
alias extundelete-sda-f='sudo extundelete /dev/sda --restore-files "$1"'	# restore list of files (use to restore single file) ("$1" = filename)
alias extundelete-sdb='sudo extundelete /dev/sdb --restore-all'			# restore all files possible to undelete
alias extundelete-sdb-d='sudo extundelete /dev/sdb --restore-directory "$1"'	# restore all files possible from specified dir.  ("$1" = path/to/directory)
alias extundelete-sdb-f='sudo extundelete /dev/sdb --restore-files "$1"'	# restore list of files (use to restore single file) ("$1" = filename)
alias extundelete-sdc='sudo extundelete /dev/sdc --restore-all'			# restore all files possible to undelete
alias extundelete-sdc-d='sudo extundelete /dev/sdc --restore-directory "$1"'	# restore all files possible from specified dir.  ("$1" = path/to/directory)
alias extundelete-sdc-f='sudo extundelete /dev/sdc --restore-files "$1"'	# restore list of files (use to restore single file) ("$1" = filename)
alias extundelete-sdd='sudo extundelete /dev/sdd --restore-all'			# restore all files possible to undelete
alias extundelete-sdd-d='sudo extundelete /dev/sdd --restore-directory "$1"'	# restore all files possible from specified dir.  ("$1" = path/to/directory)
alias extundelete-sdd-f='sudo extundelete /dev/sdd --restore-files "$1"'	# restore list of files (use to restore single file) ("$1" = filename)
alias extundelete-sde='sudo extundelete /dev/sde --restore-all'			# restore all files possible to undelete
alias extundelete-sde-d='sudo extundelete /dev/sde --restore-directory "$1"'	# restore all files possible from specified dir.  ("$1" = path/to/directory)
alias extundelete-sde-f='sudo extundelete /dev/sde --restore-files "$1"'	# restore list of files (use to restore single file) ("$1" = filename)
alias extundelete-sdf='sudo extundelete /dev/sdf --restore-all'			# restore all files possible to undelete
alias extundelete-sdf-d='sudo extundelete /dev/sdf --restore-directory "$1"'	# restore all files possible from specified dir.  ("$1" = path/to/directory)
alias extundelete-sdf-f='sudo extundelete /dev/sdf --restore-files "$1"'	# restore list of files (use to restore single file) ("$1" = filename)
alias extundelete-sdg='sudo extundelete /dev/sdg --restore-all'			# restore all files possible to undelete
alias extundelete-sdg-d='sudo extundelete /dev/sdg --restore-directory "$1"'	# restore all files possible from specified dir.  ("$1" = path/to/directory)
alias extundelete-sdg-f='sudo extundelete /dev/sdg --restore-files "$1"'	# restore list of files (use to restore single file) ("$1" = filename)
