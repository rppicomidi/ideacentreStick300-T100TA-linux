# How to set up Xubuntu 22.04 on a Lenovo ideacentre Stick 300

## Credit where credit is due
These instructions are based on the instructions I found [here](https://medium.com/@realzedgoat/a-sorta-beginners-guide-to-installing-ubuntu-linux-on-32-bit-uefi-machines-d39b1d1961ec). The instructions were close but did not quite work. I got a
hint [here](https://unix.stackexchange.com/questions/405472/cannot-find-efi-directory-issue-with-grub-install). The grub-install man page
gave me the rest of the info.

## Why did I do this?
The Lenovo ideacentre Stick 300 has a quad-core Atom processor, 2 GB of RAM and 32GB of eMMC.
It comes with 32-bit Windows 10 Home pre-installed, so I thought I would use it to run the Logitech Media Server.
I hadn't used the PC in a long time time, so I tried to update it. Windows Update is slow, and the eMMC is so
small that after updates completed there was hardly any space left. Also, Windows 10 is support is going away soon
and the Stick 300 won't support Windows 11. I thought it is time to install a version of Linux on it. As an
added bonus, the Atom processor supports 64-bit instructions, so installing Linux would give me a 64-bit OS.

## Why Xubuntu 22.04
I already have experience with Ubuntu-based distributions, and Xubuntu Linux is a light(er) weight Linux than
the standard Ubuntu Linux distribution. I like the Xfce desktop, and Xubuntu 22.04 will be supported for a long time.

## Problems to solve

1. Download Xubuntu 22.04 ISO file and burn it to a flash drive
2. Figure out how to make the Stick 300 boot from a flash drive
3. Install the Xubuntu image to eMMC
4. Debug issues booting the Xubuntu image from eMMC

## Preparing the flash drive 

I used a PC and Rufus to put the Xubuntu 22.04 AMD64 image on an old 16GB USB 2.0 flash drive.
This image won't boot on the Stick 300 because the Stick 300 requires a 32-bit UEFI bootloader
and the standard Xubuntu ISO image assumes a 64-bit UEFI bootloader. To fix this, get
the file `bootia32.efi` from [here](https://github.com/hirotakaster/baytail-bootia32.efi/blob/master/bootia32.efi)
and copy it to the EFI/boot directory on the flash drive.

## Set up the Stick 300 to boot from a flash drive

0. Before doing anything else, back up your Stick 300 and create a Windows Restore Drive with all the system files on it in case this doesn't work for you. Create the Windows Restore Drive overnight because it takes many hours for some reason. Dual boot is possible with this, but since getting rid of Windows
is my goal, I didn't set it up that way and have never tested it.
1. Connect a USB hub to the Stick 300
2. Connect your mouse, keyboard and flash drive with the Xubuntu image to the hub
3. Connect a monitor to and power to the Stick 300, and power it on.
4. When the Lenovo logo appears, press the `ESC` key repeatedly until it the screen indicates a Hot Key was detected.
5. In the Boot Menu Screen select the `Secure Boot Option` and then set `Enforce Secure Boot` to `Disabled` (see the pictures
in steps 3 & 4 [here](https://support.lenovo.com/us/en/solutions/ht118103-flash-bios-with-uefi-tool-ideacentre-stick-300).
6. Press F10 to save the changes. The Stick 300 will reboot.
7. When the Lenovo screen shows up, press F12 to get the boot option. Select the `EFI USB Device`
8. Xubuntu should start to boot.

## Try Xubuntu 22.04 and then install it.

1. You will get a choice to try or install Xubuntu. Select the try option.
2. Click the network icon to connect to WiFi. If you have a microSD card installed, make sure you
can access it. Make sure sound is working from HDMI. That is pretty much all the computer can do,
so if it is working, double click the install icon and install it. Make sure to select
install 3rd party drivers and to update while installing.
3. Installation will take a while, especially if your WiFi connection is weak.
4. When installation is complete, you will be prompted to unplug your flash drive. Do it.
The system will attempt to reboot but it won't work because the install process installs a 64-bit Grub2 image.

## Fix the Grub bootloader.

What you will do here is write the grub-efi-ia32 bootloader over the 64-bit bootloader installed on the eMMC.

1. Power off the PC, plug your flash drive with the Xubuntu image on it again and power back on.
2. Use F12 to select the `EFI USB Device` and again select `Try Xubuntu`
3. Again connect to your WiFi network.
4. Open a terminal window and type `sudo apt update`
5. When the command completes type `sudo apt install grub-efi-ia32-bin`
6. When the command completes type `mkdir /mnt/efi`
7. When the command completes type `mkdir /mnt/root`
8. When the command completes type `sudo mount /dev/mmcblk1p1 /mnt/efi`
9. When the command completes type `sudo mount /dev/mmcblk1p2 /mnt/root`
10. When the command completes type `sudo grub install --efi-directory=/mnt/efi --boot-directory=/mnt/root/boot`
11. When the command completes type `sync`
12. When command completes, cleanly shut down the Stick 300 using the GUI.
13. Remove the flash drive from the hub and power back on. The system should boot normally.
