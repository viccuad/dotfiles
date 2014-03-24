_awsssh() 
{
	local cur prev opts
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD-1]}"

	if [[ ${cur} == -* ]] ; then
		COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
		return 0
	fi

	case "${prev}" in
		-e)
			opts="production staging utility"
			COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
			return 0
			;;
		-g)
			for (( i=0; i<=${COMP_CWORD}; i++ ))
			do
				if [[ ${COMP_WORDS[i]} == "production" ]] ; then
					source $HOME/.aws/aws-production.conf
					groups=`ec2dgrp.py`
					COMPREPLY=( $(compgen -W "${groups}" -- ${cur}) )
					return 0
				fi
			done
			;;
		*)
		;;
	esac
}

#_awsssh_
complete -F _awsssh awsssh

