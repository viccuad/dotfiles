# Find out the pid of a specified process
# note that the command name can be specified via a regex
#    E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#    Without the 'sudo' it will only find processes of the current user
function findPid() { sudo /usr/bin/lsof -t -c "$@" ; }

# Kill a process by name
# copyright 2007 - 2010 Christopher Bratusek
function psgrep() {
    if [[ $1 == "-u" ]]; then
        ps aux | grep -v grep | grep $2 | awk '{ print $2 " : " $11}' | tee .temp
        CMDS=$(cat .temp)
    elif [[ $1 != "" ]]; then
        ps aux | grep -v grep | grep "$1" | awk '{ print $11 " : " $2 " : " $1 }' | tee .temp
        CMDS=$(cat .temp)
    fi
    if [[ $CMDS == "" ]]; then
        echo "no matching process"
    fi
    rm -f .temp
}



function pskill() {
    if [[ $1 ]]; then
        psgrep $1
        shift
        if [[ $CMDS != "" ]]; then
            echo -e "\nenter process number to kill:\n"
            read ID
            if [[ ! $ID == 0 || ! $ID == "" ]]; then
                kill $@ $ID
            fi
        fi
    fi
}