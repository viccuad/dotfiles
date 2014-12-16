# Determining the meaning of error codes
function err()
{
    grep --recursive --color=auto --recursive -- "$@" /usr/include/*/errno.h
    if [ "${?}" != 0 ]; then
        echo "Not found."
    fi
}

# intercept stdout/stderr of another process or disowned process
# Useful to recover a output(stdout and stderr) "disown"ed or "nohup"ep process of other instance of ssh
# usage: interceptOutput pid
function interceptOutput() {
strace -e write=1,2 -p $PID 2>&1 | sed -un "/^ |/p" | sed -ue "s/^.\{9\}\(.\{50\}\).\+/\1/g" -e 's/ //g' | xxd -r -p
}
