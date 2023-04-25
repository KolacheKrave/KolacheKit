# KolacheKit

This is a small program for use in Kolache Krave franchizes

# Installing Linux

First update Windows to install all newest firmware

Get balenaEtcher here: [https://www.balena.io/etcher](https://www.balena.io/etcher)
Get the newest version of Linux Mint Cinnamon Edition here: [https://linuxmint.com/download.php](https://linuxmint.com/download.php)

Insert a USB stick that doesn't contain anything you can't lose (this process will wipe the usb stick)

Open Balena Etcher and follow it's instructions (Use the Linux Mint .iso file you just downloaded for the "image")

Grab an appropriate usb hub (usb-a for old surface tablets and usb-c for newer ones) and a wired keyboard

Plug in the usb hub and plug in the usb stick and keyboard

Shut off the surface tablet completely

Hold the volume up button and quickly press the power button on the tablet, this should open a white screen, disable secure boot and the TPM chip, then go to boot order and move usb to the top and reboot

If all steps were followed you should see something that resembles a windows desktop with a dvd icon in the top left corner that says "install linux mint"

Run the disc icon by tripple tapping it, sometimes it takes a second for it to load

Follow the instructions, until you get to "Multimedia Codecs" make sure you check the box as the printers need them to work.

Select "Erase Disk and install Linux Mint"

Set a strong password and write it down, and set it to "Log in automatically", don't encrypt the disk

After it finishes intstalling, hit reboot now and follow the instructions on the screen

Now follow the next section:

# Installing Kolache Kit From Fresh Linux Install

Open terminal (black box with dollar sign on it in dock), copy and paste (with ctrl+shift+v as because the terminal has specific keybinds) the script below:

```bash
sudo sh -c "$(curl -s https://raw.githubusercontent.com/KolacheKrave/KolacheKit/main/install_kkit.sh)"
```

Hit enter and give it the password when prompted then hit enter again.

It will configure things for a second, and text will fly on the screen, when it's done, shut the computer off then on again and a blue box should appear, if the box wont let you enter anything on the keyboard, wait till it boots, if it does, type "surface" and select yes

Then open terminal when it boots and execute the script below (it will require your password again):

```bash
sudo update-grub; dconf write /org/cinnamon/sounds/notification-enabled "false"
```

KolacheKit.AppImage should be on the desktop now, just tripple tap it to open it up, or reboot the machine as it will open on boot!

If you want, you can either make sure everything stays up to date, or you can disconnect the wifi after you make sure your printer works

# Configuring Printers

If plugging in a printer doesn't immediately work, the steps are straightforward:

Open the printers application

Press `Add`

Select the printer under Devices and press `Forward`

It will search for drivers, when done it will pop up a window that says "Choose Driver" find the brand of printer you're looking for

Push Ok or Apply until it's installed, and don't print a test page

Select the new printer in the menu and press `Printer > Set As Default` in the top bar (Next to Server and View)

Close the window and enjoy your printer
