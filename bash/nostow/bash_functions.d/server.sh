# Reboot machine when everything is hanging, simulating power button press
alias buttonReboot='<alt> + <print screen/sys rq> + <R> - <S> - <E> - <I> - <U> - <B>'

# broadcast the shell on udp 5000
function broadcastShell() {
script -qf >(nc -ub 192.168.1.255 5000)
}