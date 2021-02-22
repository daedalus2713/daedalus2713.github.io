# Config

Change gnome themes for app in i3wm:

* [https://www.reddit.com/r/i3wm/comments/4lol1v/how\_can\_i\_change\_theme\_of\_gnome\_apps\_in\_i3/](https://www.reddit.com/r/i3wm/comments/4lol1v/how_can_i_change_theme_of_gnome_apps_in_i3/)
* [https://wiki.lxde.org/en/LXAppearance](https://wiki.lxde.org/en/LXAppearance)

Support chrome password:

* add to i3config: exec --no-startup-id /usr/bin/gnome-keyring-daemon --start --components=secrets
* add to chrome bin: "--password-store=gnome"
* fix /etc/pam.d/login: [https://wiki.archlinux.org/index.php/GNOME/Keyring\#Using\_the\_keyring\_outside\_GNOME](https://wiki.archlinux.org/index.php/GNOME/Keyring#Using_the_keyring_outside_GNOME)



