function psgrep() {
	ps -p $(pgrep $@)
}
