# atom-flatpak-wrapper

This contains small wrapper scripts that help to keep your development experience, if you install [Atom via a flatpak](https://flathub.org/apps/details/io.atom.Atom).
The scripts work around the problem that [Atom cannot access other programs directly](https://github.com/flathub/io.atom.Atom/issues/12), if it is "isolated" inside the flatpak.

**Important:** Obviously, these instructions will destroy any security benefit of having Atom in a sandboxed flatpak. However, also note that the default flatpak from Flathub is not well isolated anyway, and sandbox escapes are easily possible.

The main aim of these scripts is to provide a good developer experience (we don't call it "user experience", that would underestimate it😉).

## Setup

0. (Obviously) clone this repo.
1. Install Atom, usually [from flathub](https://flathub.org/apps/details/io.atom.Atom).
2. Your flatpak needs the permission to break out of the flatpak and spawn a command on the host system instead. This is likely already done, [especially for flathub version](https://github.com/flathub/io.atom.Atom/issues/43).  
  To add this permission, run this as root:
  ```sh
  # flatpak override io.atom.Atom --talk-name=org.freedesktop.Flatpak
  ```
3. Run [`./setup-flatpak-atom.sh`](setup-flatpak-atom.sh) to setup the scripts in an accessible dir (by default `~/bin`) for Atom. You may need to manually copy the paths to the scripts into your scripts, but the script will tell you this, if needed.

## Wrappers included

* [`flatpak-gpg2.sh`](flatpak-gpg2.sh) – wrapping around gpg(2) letting you **sign git commits** inside of Atom (as you would do on the host)
* [`flatpak-shellcheck.sh`](flatpak-shellcheck.sh) – wrapping around **shellcheck** letting you use [shellcheck inside of Atom](https://atom.io/packages/linter-shellcheck)
 
## Contributing

Feel free to add additional wrappers. 😃
