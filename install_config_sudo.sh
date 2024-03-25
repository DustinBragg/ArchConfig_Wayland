#!/bin/bash

#//
#// This script is idempotent, so you don't have to be too careful.
#//

#// Root check
if [[ $EUID != 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

if [ "$1" != "-s" ]; then
   echo "Make sure you ran the normal 'install_config.sh' file first. Things will not work properly if you haven't run that script first."
   echo ""
   echo "Once you have, or if you just really want to run just this one, run this script again with the '-s' flag."
   exit 1
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

#// Get user name
Username=$SUDO_USER

#// Install fonts
section_header "Installing fonts..."
mkdir -p /usr/local/share/fonts
cp -r ./files/root/usr/local/share/fonts/* /usr/local/share/fonts/
sudo -u $Username fc-cache -f

#// Enable 'sddm'
section_header "Enable 'sddm'..."
systemctl enable sddm

#// Output at the end, notes and final instructions
echo ""
echo "---------------"
echo "+ Complete +"
#echo "*NOTE* "
echo "---------------"
echo "When finished with the above notes (if any), reboot to complete configuration."
