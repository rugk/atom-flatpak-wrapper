#!/bin/sh
#
# Setup the binary wrappers.
#
# Parameter:
# $1  location/dir, where binaries should be placed (will actually be symblinked
#     to these ones here), default = ~/bin
# $2 = "--relative" (default) Use the relative path for creating the symbolic links
# $2 = "--absolute" (default) Use the absolute path for creating the symbolic links
#

# installs the binaries into this location
locationDir="$HOME/bin"
test -d "$1"&&locationDir="$1"

# save current dir, which contains scripts
scriptDir="$PWD"

# switch to new location
mkdir -p "$locationDir"
cd "$locationDir"||exit 1

if [ "$2" != "--absolute" ]; then
  # use absolute path for the symbolic links
  relativeScriptsDir="$scriptDir"
else
  # find relative path to dir of scripts, thanks https://stackoverflow.com/a/28523143/5008962
  relativeScriptsDir="$( realpath --relative-to "$PWD" "$scriptDir" )"
fi

# install shellcheck wrapper
SHELLCHECK_WRAPPER="flatpak-shellcheck.sh"

ln -s "$relativeScriptsDir/$SHELLCHECK_WRAPPER" .

echo "Enter this path for shellcheck config: $locationDir/$SHELLCHECK_WRAPPER"

# install gpg2 wrapper
GPG_WRAPPER="flatpak-gpg.sh"

ln -s "$relativeScriptsDir/$GPG_WRAPPER" .

echo "This path for gpg program in git config will be added: $locationDir/$GPG_WRAPPER"
git config  --global gpg.program "$locationDir/$GPG_WRAPPER"

# secure own dir
# sudo chown root:root -R "$locationDir"
# sudo chown root:root -R "$scriptDir"

