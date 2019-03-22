#!/bin/sh
#
# Wrapper for shellcheck to let one use shellcheck inside of an Atom flatpak.
#

# --sandbox and --no-network do not work
flatpak-spawn --host --clear-env shellcheck "$@"
