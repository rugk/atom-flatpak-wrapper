#!/bin/sh
#
# Wrapper for git signature to 
#

# --sandbox and --no-network do not work
flatpak-spawn --host --clear-env shellcheck "$@"
