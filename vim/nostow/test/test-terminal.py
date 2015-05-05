#!/usr/bin/env python

import sys

sys.stdout.write("\nTEXT ATTRIBUTES:\n\n")
sys.stdout.write("  Normal: \033[0mNormal text\033[0m\n")
sys.stdout.write("  Bold:   \033[1mBold text\033[0m\n")
sys.stdout.write("  Faint:  \033[2mFaint text\033[0m\n")
sys.stdout.write("  Italic: \033[3mItalic text\033[0m\n")
sys.stdout.write("  Underlined:       \033[4mUnderlined text\033[0m\n")
sys.stdout.write("  Slowly blinking:  \033[5mSlowly blinking text\033[0m\n")
sys.stdout.write("  Quickly blinking: \033[6mQuickly blinking text\033[0m\n")
sys.stdout.write("  inverted colors:  \033[7mInverted colors\033[0m\n")

sys.stdout.write("\nNORMAL COLORS 0-7:\n\n  ")
for n in range(8):
    sys.stdout.write("\033[0;" + str(40 + n) + "m\033[30m " + str(n) + " \033[0m")

sys.stdout.write("\n\n256 COLORS:\n\n  ")
for i in range(0, 2):
    for j in range(0, 8):
        n = (8 * i) + j
        s = " " + str(n) + " "
        if n < 10:
            s = " " + s
        sys.stdout.write("\033[48;5;" + str(n) + "m\033[38;5;16m " + s + " \033[0m")
    sys.stdout.write("\n  ")

sys.stdout.write("\n  ")
for k in [0, 2, 4]:
    for i in range(0, 6):
        for j in range(16, 22):
            n = (36 * k) + (6 * i) + j
            s = " " + str(n)
            if n < 100:
                s = " " + s
            sys.stdout.write("\033[0;48;5;" + str(n) + "m\033[38;5;16m " + s + " \033[0m")
        sys.stdout.write("  ")
        for j in range(52, 58):
            n = (36 * k) + (6 * i) + j
            s = " " + str(n)
            if n < 100:
                s = " " + s
            sys.stdout.write("\033[0;48;5;" + str(n) + "m\033[38;5;16m " + s + " \033[0m")
        sys.stdout.write("\n  ")
    sys.stdout.write("\n  ")

for i in range(232, 244):
    sys.stdout.write("\033[0;48;5;" + str(i) + "m\033[38;5;16m " + str(i) + " \033[0m")
sys.stdout.write("\n  ")
for i in range(244, 256):
    sys.stdout.write("\033[0;48;5;" + str(i) + "m\033[38;5;16m " + str(i) + " \033[0m")
sys.stdout.write("\033[0m\n\n")
