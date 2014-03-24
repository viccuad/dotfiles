
# Find top 5 big files
alias findbig="find . -type f -exec ls -s {} \; | sort -n -r | head -5"

# Clear the screen and list file
alias cls='clear;ls'

# To navigate to the different directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# List folders by disk usage
alias folders='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'

# Progress bar on file copy. Useful evenlocal.
alias cpProgress="rsync --progress -ravz"

# See currently mounted filesystems in nice layout
alias seeFilesystems="mount | column -t"