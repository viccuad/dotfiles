# Run a command until a specified time
# Example: command-timer 04:00
function command-timer() { echo "notify-send TimeToQuit" | at "$@" ; }



# Run a program on a timer
# Example: program-timer 20 viewnior arg1
function program-timer() { perl -e 'alarm shift; exec @ARGV' "$@" & exit; }

# Reminder for whatever whenever
function remindme()
{
sleep $1 && zenity --info --text "$2" &
}

# Stopwatch
function stopwatch() {
# copyright 2007 - 2010 Christopher Bratusek
BEGIN=$(date +%s)
while true; do
    NOW=$(date +%s)
    DIFF=$(($NOW - $BEGIN))
    MINS=$(($DIFF / 60))
    SECS=$(($DIFF % 60))
    echo -ne "Time elapsed: $MINS:`printf %02d $SECS`\r"
    sleep .1
done
}