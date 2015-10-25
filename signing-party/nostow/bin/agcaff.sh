#!/bin/sh
# Airgapped key-signing with caff
#
# You need:
# - an encrypted partition only unlocked offline for holding your master secret key
#   - you must manually put your .caffrc and .gnupg here, before using this tool
# - an unencrypted partition for transporting data between online/offline systems
#   - this tool will overwrite .caff, $0, $0.state, and ksp-keys.txt
#
# Usage:
#  online$ bhome=/$transport_dir agcaff init
# offline$ shome=/$secure_dir /$transport_dir/agcaff  # or, for auto-unlock:
# offline$ sdev=/dev/sda2 srel=home/infinity0 /$transport_dir/agcaff
#  online$ /$transport_dir/agcaff
#
# TODO(infinity0): copy a signed copy of this script into the storage medium,
# so people can check that the agcaff they're running isn't compromised.
#
# Your local mail client must work such that `mail $arbitrary_address` works
# without further flags, since this is what caff does. Quick-and-dirty
# instructions for configuring exim4 with remote SMTP:
#
# $ sudo dpkg-reconfigure exim4-config
#   - General type of mail configuration: "mail sent by smarthost; received via SMTP or fetchmail"
#   - IP address or host name of the outgoing smarthost: input your SMTP server address
# # then add your email to /etc/email-addresses
# # then add your password to /etc/exim4/passwd.client
# TODO(infinity0): write some snippets to install this automatically and
# test its functionality

SCRIPT_DIR="$(dirname "$0")"
STATE_FILE="$(basename "$0").state"

abort() { echo "$@"; exit 1; }

file_on_removable_dev() {
	local dev
	dev=$(readlink -f /sys/class/block/$(basename $(readlink -f "$(df "$1" | cut -d\  -f1 | tail -n1)")))
	if test -f "$dev/removable"; then
		test "$(cat "$dev/removable")" = "1"
	elif test -f "$dev/../removable"; then
		test "$(cat "$dev/../removable")" = "1"
	else
		false
	fi
}

auto_set_bhome() {
	if test -z "$bhome" -a -f "$SCRIPT_DIR/ksp-keys.txt" && file_on_removable_dev "$SCRIPT_DIR"; then
		bhome="$SCRIPT_DIR"
		echo "\$bhome automatically set to $SCRIPT_DIR"
	fi
}

out_of_date_reset() {
	test "$(find "$1" -mtime +0)" && { \
		read -p "$1 was modified more than a day ago; reset? [y/N] " x; test "$x" = "y"; }
}

agcaff_init() {
	# get input from ksp-keys.txt (if it's non-empty and fresh) or else stdin
	test ! -s "$bhome/ksp-keys.txt" \
	  || out_of_date_reset "$bhome/ksp-keys.txt" \
	  && { echo 'type the keys you want to sign, one-per-line. ctrl-D when done'; cat > "$bhome/ksp-keys.txt"; }

	set -x
	caff --no-sign --no-export-old --no-mail "$(cat $bhome/ksp-keys.txt)"
	cp -aL --no-preserve=ownership -t "$bhome" "$HOME/.caff"
	test "$SCRIPT_DIR" != "$bhome" && cp -aL --no-preserve=ownership -t "$bhome" "$0"
	echo sign > "$bhome/$STATE_FILE"
	set +x
	echo "saved {$0, ksp-keys.txt, ~/.caff} to $bhome"
	echo "NEXT STEP: on your secure offline system, run \$transport_directory/$(basename $0) sign"
}

agcaff_sign() {
	test -s "$bhome/ksp-keys.txt" || abort "\$bhome/ksp-keys.txt empty; did you run \`$0 init\` on your online system?"

	# TODO: this should not be necessary
	if ! command -v caff >/dev/null; then
		read -p "we have to connect to the internet to install caff; press enter to continue or ctrl-C to abort" x
		sudo aptitude update
		sudo aptitude install signing-party
		read -p "disconnect the internet and insert your offline secure medium, then press enter to continue" x
	fi

	if test -z "$shome"; then
		test -b "$sdev" -a -n "$srel" || abort "set shome to a directory on your secure partition, or else set sdev to the secure partition and srel to a relative directory within it"
		test -e /dev/mapper/x || sudo cryptsetup luksOpen "$sdev" x
		mkdir -p /media/x
		shome="/media/x/$srel"
		test -d "$shome" || sudo mount /dev/mapper/x /media/x
		test -d "$shome" || abort "sdev/srel did not point to a valid shome: $sdev $srel"
	fi
	test -w "$bhome/.caff" || abort "$bhome/.caff is not writable"
	test -d "$shome" || abort "set shome to a directory on your secure partition (where .caffrc and .gnupg are)."
	echo "using secure offline medium $shome"

	set -x
	cp -aL --no-preserve=ownership -t "$HOME" "$bhome/.caff" "$shome/.caffrc" "$shome/.gnupg"
	ln -sf ../../.gnupg/private-keys-v1.d "$HOME/.caff/gnupghome"
	caff --no-download --no-export-old --no-mail "$(cat $bhome/ksp-keys.txt)"
	rm -f "$HOME/.caff/gnupghome/private-keys-v1.d"
	cp -aL --no-preserve=ownership -t "$bhome" "$HOME/.caff"
	remoteugid=$(stat -c %u:%g "$bhome/ksp-keys.txt")
	if test "$(id -u):$(id -g)" != "$remoteugid"; then
		sudo chown -R "$remoteugid" "$bhome/.caff"
	fi
	echo post > "$bhome/$STATE_FILE"
	set +x
	echo "keys signed and copied back to $bhome/.caff"
	echo "NEXT STEP: on your online system, run \$transport_directory/$(basename $0) post"
}

agcaff_post() {
	test -s "$bhome/ksp-keys.txt" || abort "\$bhome/ksp-keys.txt empty; did you run \`$0 init\` on your online system?"

	set -x
	cp -aL --no-preserve=ownership -t "$HOME" "$bhome/.caff"
	caff --no-download --no-sign --no-export-old "$(cat $bhome/ksp-keys.txt)"
	echo init > "$bhome/$STATE_FILE"
	mv "$bhome/ksp-keys.txt" "$bhome/ksp-keys.txt.done"
	set +x
	echo "signed keys encrypted and mailed."
	echo "KEYSIGNING COMPLETE. completed keyids listed in $bhome/ksp-keys.txt.done"
}

set -e
auto_set_bhome
test -d "$bhome" || abort "set bhome to a directory on your transport medium"
echo "using transport medium $bhome"

step="$1"
if test -z "$step"; then
	test ! -f "$bhome/$STATE_FILE" || out_of_date_reset "$bhome/$STATE_FILE" && echo init > "$bhome/$STATE_FILE"
	step="$(cat $bhome/$STATE_FILE)"
	echo "automatically running: $step"
fi
case "$step" in
init|sign|post) true;;
*) abort "Usage: $0 <init|sign|post>";;
esac
export bhome
"agcaff_$step"
