#!/bin/bash

# Check if run as root
if [ "$(whoami)" != "root" ]; then
    echo "You need to run this as root (via sudo), properly copy the whole command from the github repository"
    exit
fi

wget -qO - https://raw.githubusercontent.com/linux-surface/linux-surface/master/pkg/keys/surface.asc \
    | gpg --dearmor | dd of=/etc/apt/trusted.gpg.d/linux-surface.gpg

echo "deb [arch=amd64] https://pkg.surfacelinux.com/debian release main" \
	| tee /etc/apt/sources.list.d/linux-surface.list

apt update

notify-send "Downloading Packages..." "Don't shut off anything!"

apt install linux-image-surface linux-headers-surface libwacom-surface iptsd

apt install linux-surface-secureboot-mok

cd /home/"$(ls /home)"/Desktop

curl -LJO https://github.com/KolacheKrave/KolacheKit/releases/download/Main-Release/KolacheKit.AppImage

chmod +x KolacheKit.AppImage

clear

echo "Ready to reboot, a blue box will appear \n\n Type 'surface' and select 'yes' \n\n Press 'enter' to reboot!"

notify-send "Next step ready" "Check the terminal for more information"

read input

reboot now
