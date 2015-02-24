autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
		git="$commands[git]"
else
		git="/usr/bin/git"
fi

git_branch() {
		echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
		st=$($git status 2>/dev/null | tail -n 1)
		if [[ ! -d .git ]]
		then
				echo ""
		else
				if [[ $($git status --porcelain) == "" ]]
				then
						echo " on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
				else
						echo " on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
				fi
		fi
}

git_prompt_info () {
		ref=$($git symbolic-ref HEAD 2>/dev/null) || return
		# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
		echo "${ref#refs/heads/}"
}

unpushed () {
		$git cherry -v @{upstream} 2>/dev/null
}

need_push () {
		if [[ $(unpushed) == "" ]]
		then
				echo ""
		else
				echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%}"
		fi
}

ruby_version() {
		if (( $+commands[rbenv] ))
		then
				echo "$(rbenv version | awk '{print $1}')"
		fi

		if (( $+commands[rvm-prompt] ))
		then
				echo "$(rvm-prompt | awk '{print $1}')"
		fi
}

rb_prompt() {
		if ! [[ -z "$(ruby_version)" ]]
		then
				echo "%{$fg_bold[yellow]%}$(ruby_version)%{$reset_color%} "
		else
				echo ""
		fi
}

directory_name() {
		echo "%{$fg_bold[blue]%}%~%{$reset_color%}"
}

last_status() {
		echo "%{$fg_bold[cyan]%}%n@%M%{$reset_color%}%(?..%{$fg_bold[red]%} %?% %{$reset_color%})"
}


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
#
# Ensures that $terminfo values are valid and updates editor information when
# the keymap changes.
function zle-keymap-select zle-line-init zle-line-finish {
		# The terminal must be in application mode when ZLE is active for $terminfo
		# values to be valid.
		if (( ${+terminfo[smkx]} )); then
				printf '%s' ${terminfo[smkx]}
		fi
		if (( ${+terminfo[rmkx]} )); then
				printf '%s' ${terminfo[rmkx]}
		fi
		zle reset-prompt
		zle -R
}
# Ensure that the prompt is redrawn when the terminal size changes.
TRAPWINCH() {
		zle && { zle reset-prompt; zle -R }
}
zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
zle -N edit-command-line

# if mode indicator wasn't setup by theme, define default
if [[ "$MODE_INDICATOR" == "" ]]; then
		MODE_INDICATOR="%{$fg_bold[white]%}--NORMAL--%{$reset_color%}"
fi

function vi_mode_prompt_info() {
		echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
}





export PROMPT=$'\n$(rb_prompt)$(last_status) $(directory_name)$(git_dirty)$(need_push) > '
set_prompt () {
		#export RPROMPT="$(notes_prompt TODO) %{$fg_bold[yellow]%}$(notes_prompt HACK)%{$reset_color%} %{$fg_bold[red]%}$(notes_prompt FIXME)%{$reset_color%} %{$fg_bold[blue]%}$(todo_prompt +next)%{$reset_color%} %{$fg[blue]%}%T%{$reset_color%}"
		# export RPROMPT="%{$fg_bold[blue]%}$(todo_prompt @next)%{$reset_color%} %{$fg[blue]%}%T%{$reset_color%}"
		RPS1='$(vi_mode_prompt_info) %{$fg_bold[blue]%}$(todo_prompt @next)%{$reset_color%} %{$fg[blue]%}%T%{$reset_color%}'

}

precmd() {
		set_prompt
}

# define right prompt, if it wasn't defined by a theme
# if [[ "$RPS1" == "" && "$RPROMPT" == "" ]]; then
		# RPS1='$(vi_mode_prompt_info)'
# fi
