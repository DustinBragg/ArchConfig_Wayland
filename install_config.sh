#!/bin/bash

#//
#// This script is idempotent, so you don't have to be too careful.
#//

#// Non-root check
if [[ $EUID == 0 ]]; then
    echo "This script must be run as a normal user, not root."
    echo "You will be prompted for sudo password during script execution for 'yay'."
    exit 1
fi

which git &> /dev/null
if [ $? != 0 ]; then
    echo "You need to install 'git' first: sudo pacman -S git"
    exit 2
fi

section_header () {
	echo ""
	echo "---------------"
	echo ""
	echo $1
}

section_header_with_output () {
	section_header "$1"
	echo "---"
}

#// Parallel pacman downloads notice
grep "#ParallelDownloads" /etc/pacman.conf &> /dev/null
if [ $? == 0 ] && [ "$1" != "-s" ]; then
   echo "Before continuing, you may want to enable parallel downloads in pacman for a faster install experience."
   echo "With root privileges, uncomment 'ParallelDownloads' in '/etc/pacman.conf' and increase the value if desired."
   echo "If you don't want to do this, run this script again with the '-s' flag."
   exit 1
fi

#// Get path to user's home directory
USER_HOME=$HOME

#// Make home directories
section_header "Making home directories..."
mkdir -p "$USER_HOME/Downloads"
mkdir -p "$USER_HOME/Games"
mkdir -p "$USER_HOME/Pictures"
mkdir -p "$USER_HOME/Scratch"
mkdir -p "$USER_HOME/Scripts"
mkdir -p "$USER_HOME/Shortcuts"
mkdir -p "$USER_HOME/Software"

#// Install yay, an AUR helper, if not installed.
#// Operate from inside '~/Scratch' from here on
section_header "Installing yay..."
pushd "$USER_HOME/Scratch"
   git clone https://aur.archlinux.org/yay-bin.git
   chmod a+w yay-bin
   pushd yay-bin
       makepkg -si --noconfirm
   popd
   rm -rf "$USER_HOME/Scratch/yay-bin"
popd

#// Install packages from the 'config' package list
section_header_with_output "Installing packages..."
yay -S --noconfirm --sudoloop --needed - < config_package_list.txt

#// Copy over user config/dot files
section_header_with_output "Copying over config/dot files..."
rsync -av ./files/home/ ~/

#// Output at the end, notes and final instructions
echo ""
echo "---------------"
echo "+ Complete +"
#echo "*NOTE* "
echo "---------------"
echo "When finished with the above notes (if any), run 'install_config_sudo.sh' as root to continue."
