#!/bin/sh

# installs the 
LOCATION_DIR="$HOME/bin"

# save current dir, which contains scripts
scriptDir="$PWD"

# switch to new location
mkdir -p "$LOCATION_DIR"
cd "$LOCATION_DIR"||exit 1

# find relative path to dir of scripts, thanks https://stackoverflow.com/a/28523143/5008962
relativeScriptsDir="$( realpath --relative-to "$PWD" "$scriptDir" )"

# install shellcheck wrapper
SHELLCHECK_WRAPPER="flatpak-shellcheck.sh"

ln -s "$relativeScriptsDir/$SHELLCHECK_WRAPPER" .

# /usr is mounted to /var/run/host/usr, see https://github.com/flathub/io.atom.Atom/issues/12#issuecomment-474555053
echo "Enter this path for shellcheck config: $LOCATION_DIR/$SHELLCHECK_WRAPPER"

# install gpg2 wrapper
GPG_WRAPPER="flatpak-gpg.sh"

ln -s "$relativeScriptsDir/$GPG_WRAPPER" .

echo "This path for gpg program in git config will be added: $LOCATION_DIR/$GPG_WRAPPER"
git config  --global gpg.program "$LOCATION_DIR/$GPG_WRAPPER"

# secure own dir
# sudo chown root:root -R "$LOCATION_DIR"
# sudo chown root:root -R "$scriptDir"

