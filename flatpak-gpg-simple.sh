#!/bin/sh
#
# Just executes gpg or gpg2. As gpg is usually available in a flatpak, this
# does not need o spawn anything (on the host), but just keep it inside the flatpak.
#
# This helps, if your (modern) gpg on the host is e.g. named gpg2, but "gpg"
# inside of the flatpak.
#

# finally spawn either gpg2 or gpg
if command -v gpg2 >/dev/null; then
	gpgProgram="${gpgProgram}gpg2"
else
	gpgProgram="${gpgProgram}gpg"
fi

$gpgProgram "$@"
