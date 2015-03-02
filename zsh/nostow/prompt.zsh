# load ZSH colors, easier than bash ones
autoload colors && colors

# GIT prompt:
# at ./git-prompt.zsh
export GIT_PS1_SHOWDIRTYSTATE="true"
export GIT_PS1_SHOWSTASHSTATE="true"
export GIT_PS1_SHOWUNTRACKEDFILES="true"
export GIT_PS1_SHOWUPSTREAM="auto verbose"
export GIT_PS1_DESCRIBE_STYLE="branch"
export GIT_PS1_SHOWCOLORHINTS="true"
export GIT_PS1_HIDE_IF_PWD_IGNORED="true"

## TODO.txt prompt:

# This keeps the number of todos always available the right hand side of my
# command line. I filter it to only count those tagged as "next", so it's more
# of a motivation to clear out the list. $1 = @next
todo_count(){
		if (( $+commands[todo.sh] )) then
				num=$(echo $(todo.sh ls $1 | awk -v pattern="$1" '$0 ~ pattern && !/ x /{count++} END {print count}'))
				echo $num
		else
				echo 0
		fi
}

function todo_prompt() {
		local COUNT=$(todo_count $1);
		if [ -z $COUNT ]; then
				echo "";
		else
				echo "$1: $COUNT";
		fi
}

rprompt_todo() {
echo  "%{$fg[white]%}$(todo_prompt @next)%{$reset_color%}"
}

# function notes_count() {
#   if [[ -z $1 ]]; then
#     local NOTES_PATTERN="TODO|FIXME|HACK";
#   else
#     local NOTES_PATTERN=$1;
#   fi
#   grep -ERn "\b($NOTES_PATTERN)\b" {app,config,lib,spec,test} 2>/dev/null | wc -l | sed 's/ //g'
# }

# function notes_prompt() {
#   local COUNT=$(notes_count $1);
#   if [ $COUNT != 0 ]; then
#     echo "$1: $COUNT";
#   else
#     echo "";
#   fi
# }


# VIM prompt:

function zle-keymap-select zle-line-init
{
		# RPROMPT=""
		RPROMPT=" $(rprompt_todo) $(rprompt_time)"
		[[ $KEYMAP = vicmd ]] && RPROMPT="%{$fg_bold[white]%}--NORMAL--%{$reset_color%}"
		zle reset-prompt
}
zle -N zle-keymap-select
zle -N zle-line-init

# PROMPT build:

prompt_pwd() {
		echo "%{$fg_bold[white]%}%~%{$reset_color%}"
}

prompt_names() {
		echo "%{$fg_bold[yellow]%}%n@%M%{$reset_color%}"
}

prompt_symbol() {
		echo "%{$fg_bold[white]%}$%{$reset_color%}"
}
prompt_last_status() {
		echo "%(?..%{$fg_bold[red]%} %?% %{$reset_color%})"
}

rprompt_time() {
	echo "%{$fg[white]%}%T%{$reset_color%}"
}



precmd() {
		# set_prompt
		__git_ps1 "$(prompt_names)$(prompt_last_status) $(prompt_pwd)" "$(prompt_symbol) "
		RPROMPT="$(rprompt_todo) $(rprompt_time)"
}
