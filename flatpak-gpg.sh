#!/bin/sh
#
# Wrapper for git's signature via gpg to let one sign git comits inside of an
# Atom flatpak. 
#

if [ -x gpg2 ]; then
	GPG_PROGRAM="gpg2"
else
	GPG_PROGRAM="gpg"
fi

# if this runs in a flatpak, spawn a command on the host instead
if [ "$FLATPAK_ID" != "" ]; then
	# --sandbox, --clear-env and --no-network do not work
	flatpak-spawn --host $GPG_PROGRAM "$@"
else
	# This is used when we sign a git commit outside of a flatpak
	$GPG_PROGRAM "$@"
fi

