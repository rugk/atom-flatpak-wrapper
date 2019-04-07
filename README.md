# atom-flatpak-wrapper

This contains small wrapper scripts that help to keep your development experience, if you install [Atom via a flatpak](https://flathub.org/apps/details/io.atom.Atom).
The scripts work around the problem that [Atom cannot access other programs directly](https://github.com/flathub/io.atom.Atom/issues/12), if it is "isolated" inside the flatpak.

**Important:** Obviously, these instructions will destroy any security benefit of having Atom in a sandboxed flatpak. However, also note that the default flatpak from Flathub is not well isolated anyway, and sandbox escapes are easily possible.

The main aim of these scripts is to provide a good developer experience (we don't call it "user experience", that would underestimate it 😉).

## Setup

0. (Obviously) clone this repo.
1. Install Atom, usually [from flathub](https://flathub.org/apps/details/io.atom.Atom).
2. Your flatpak needs the permission to break out of the flatpak and spawn a command on the host system instead. This is likely already done, [especially for flathub version](https://github.com/flathub/io.atom.Atom/issues/43).  
   To add this permission, run this as root:
   ```sh
   # flatpak override io.atom.Atom --talk-name=org.freedesktop.Flatpak
   ```
3. Run [`./setup-flatpak-atom.sh`](setup-flatpak-atom.sh) to setup the scripts in an accessible dir (by default `~/bin`) for Atom. You may need to manually copy the paths from the output into your config files, but the script will tell you this, if needed.

After that, you should be done. 🙂

### System-wide installation

**Note:** Obviously, this required `host` filesystem access of the flatpak, `home` access is not enough.

If do not want your paths to be in the home dir of the user, because you e.g. have a system-wide installation of your IDE (Atom, …) and you do not want to duplicate this repo, you can move it to a dir accessible by all users (if in doubt, maybe `/opt`) and run the script from there. Note you then also need to pass a custom path for the symbolic links to be created and you can use the second argument to force an absolute instead of relative path for the symbolic links. Here is an example:

```sh
./setup-flatpak-atom.sh /opt/flatpak-wrapper --absolute
```

**Note**: If you want to follow the proper file path conventions, you can also use `/usr/local/bin` for the symbolic links. Note, however, that inside of flatpaks, the directory is accessible as `/var/run/host/usr/local/bin`, so you may need to replace this path.
Usually, this is no problem if you can keep the resulting wrapper to be only executed in the flatpak (e.g. the shellcheck one), but the git/gpg one needs to be set in your `.gitconfig`, which also executes the wrapper outside of the flatpak if you use the affected git commands there. This will then obviously fail, as the path `/var/run/host/usr/local/bin` is obviously _not_ accessible outside of your flatpak. This is also why the `flatpak-gpg.sh` includes a mechanism to detect whether it is running inside of a flatpak by default.

## Wrappers included

* [`flatpak-gpg2.sh`](flatpak-gpg2.sh) – wrapping around gpg(2) letting you **sign git commits** with Atom by spawning the command on the host
* [`flatpak-gpg2-simple.sh`](flatpak-gpg2-simple.sh) – wrapping around gpg(2) that just selects the correct gpg/gpg2 binary. Can sign git commits inside of the flatpak.
* [`flatpak-shellcheck.sh`](flatpak-shellcheck.sh) – wrapping around **shellcheck** letting you use [shellcheck inside of Atom](https://atom.io/packages/linter-shellcheck)

## Tips

* Note that if the flatpak has `host` permissions for the filesystem access, you do not need any workarounds, and you can just use the path `/var/run/host/usr/local/bin/example` to e.g. run `/usr/local/bin/example` inside of the flatpak, so just enter/use that, wherever it is requested.
  However, note that the program is obviously restricted by the permissions of the flatpak.
 
## Contributing

Feel free to add additional wrappers. 😃
