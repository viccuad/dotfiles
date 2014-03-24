#!/bin/bash
ALERT="Hey Dummy!"
NOTIFIER=notify-send
LIVE=true
NAME=$(basename $0)

shifts=0

while getopts "hda:n:p:s:b:" option; do
    case $option in
        h)
            echo -n "$NAME - Alert yourself that a long-running "
            echo    "process has completed"
            echo    "---"
            echo    "-h - display this help"
            echo -n "-d - dry run - don't execute the program, just simulate "
            echo    "what would happen if you did"
            echo    "-a - summary/alert text (defaults to \"Hey Dummy!\")"
            echo    "-n - the notifier app (defaults to \`notify-send\`)"
            echo    "-p - process to attach to"
            echo    "-s - summary flag"
            echo    "-b - body flag"
            echo    "For examples or more information, go here:"
            echo https://github.com/charlesthomas/hey_dummy/blob/master/README.md
            exit
        ;;
        d)
            unset LIVE
            shifts=$shifts+1
        ;;
        a)
            ALERT=$OPTARG
            shifts=$shifts+2
        ;;
        n)
            NOTIFIER=$OPTARG
            shifts=$shifts+2
        ;;
        p)
            PID=$OPTARG
            shifts=$shifts+2
        ;;
        s)
            SUMMARY_FLAG=$OPTARG
            shifts=$shifts+2
        ;;
        b)
            BODY_FLAG=$OPTARG
            shifts=$shifts+2
        ;;
    esac
done

while [[ shifts -gt 0 ]]; do
    shift
    shifts=$shifts-1
done

if [[ $LIVE ]] && [[ $PID ]]; then
    while kill -0 $PID &>/dev/null; do
        sleep 1
    done
    exit=0
    cmd="Process \#$PID"
elif [[ $LIVE ]]; then
    cmd=$1
    $@
    exit=$?
fi

if [[ $exit -ne 0 ]]; then
    status='FAILED'
else
    status='finished'
fi

$NOTIFIER $SUMMARY_FLAG "$ALERT" $BODY_FLAG "$cmd $status"
