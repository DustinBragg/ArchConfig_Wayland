# New Arch configuration under Wayland with Sway
This config is a lot less generic than my other one, and is meant to be a much more one-click solution for my machine. Things like display layout and night-light location information are hardcoded into the dotfiles.

Random apps I use also aren't a separate install script anymore.

# Installation
Clone this repo and then run the scripts inside from within that cloned directory.

First run as a regular user:
```
./install_config.sh
```

Then run:
```
sudo ./install_config_sudo -s
```

Then reboot!