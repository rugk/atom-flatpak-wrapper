#!/bin/sh
#
# Wrapper for git's signature via gpg to let one sign git comits inside of an
# Atom flatpak. 
#

# first determinate whether we need to spawn anything to get outside of the flatpak
flatpakSpawn=""
# if this runs in a flatpak, spawn a command on the host instead
if [ "$FLATPAK_ID" != "" ]; then
	# --sandbox, --clear-env and --no-network do not work
	flatpakSpawn="flatpak-spawn --host"
	gpgProgram="$flatpakSpawn "
else
	# This is used when we sign a git commit outside of a flatpak
	gpgProgram=""
fi

# finally spawn either gpg2 or gpg
if $flatpakSpawn command -v gpg2 >/dev/null; then
	gpgProgram="${gpgProgram}gpg2"
else
	gpgProgram="${gpgProgram}gpg"
fi

$gpgProgram "$@"
