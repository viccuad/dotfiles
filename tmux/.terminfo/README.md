tmux supports italics, yet uses Screen's terminfo. Work is underway to create a
Tmux terminfo to be added to the terminfo database. As it will need some time
to trickle down to distros, we are going to make our own Tmux terminfo until
that day arrives.

Caveats of this method: until the new Tmux terminfo trickles down, when
connecting to remote servers, you won't have italics support.

#Instructions
See http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/FAQ

Screen's terminfo description lacks italics mode and has standout mode in its
place, but using the same escape sequence that urxvt uses for italics. This
means applications (like vim) looking for italics will not find it and might
turn to reverse in its place, while applications (like less) asking for
standout will end up with italics instead of reverse. To make applications
aware that tmux supports italics and to use a proper escape slequence for
standout, you'll need to create a new terminfo file with modified sgr, smso,
rmso, sitm and ritm entries:

	$ mkdir $HOME/.terminfo/
	$ screen_terminfo="screen"
	$ infocmp "$screen_terminfo" | sed \
	  -e 's/^screen[^|]*|[^,]*,/screen-it|screen with italics support,/' \
	  -e 's/%?%p1%t;3%/%?%p1%t;7%/' \
	  -e 's/smso=[^,]*,/smso=\\E[7m,/' \
	  -e 's/rmso=[^,]*,/rmso=\\E[27m,/' \
	  -e '$s/$/ sitm=\\E[3m, ritm=\\E[23m,/' > /tmp/screen.terminfo
	$ tic /tmp/screen.terminfo

And tell tmux to use it in ~/.tmux.conf:

	set -g default-terminal "screen-it"

If your terminal supports 256 colors, use:

	$ screen_terminfo="screen-256color"
	$ infocmp "$screen_terminfo" | sed \
	  -e 's/^screen-256color[^|]*|[^,]*,/screen-256color|screen with italics support,/' \
	  -e 's/%?%p1%t;3%/%?%p1%t;7%/' \
	  -e 's/smso=[^,]*,/smso=\\E[7m,/' \
	  -e 's/rmso=[^,]*,/rmso=\\E[27m,/' \
	  -e '$s/$/ sitm=\\E[3m, ritm=\\E[23m,/' > /tmp/screen.terminfo
	$ tic /tmp/screen.terminfo

instead of "screen". See the FAQ entry about 256 colors support for more info.
Also note that tmux will still display reverse video on terminals that do not
support italics.

If your urxvt cannot display italics at all, make sure you have an italics
capable font enabled, for example, add to ~/.Xdefaults:

	urxvt.italicFont: xft:Bitstream Vera Sans Mono:italic:autohint=true


