# How to set up Xubuntu 22.04 on the Lenovo ideacentre Stick 300 or the Asus T100TA

## Introduction
These instructions and external hyperlinks work today. There will probably come a time when they no longer work.
The instructions apply to both the Lenovo ideacentre Stick 300 and the Asus T100TA unless the heading over the steps
says otherwise. I believe these instructions will work on the Intel Compute Stick that shipped with Windows because
I believe the hardware is the same as the Stick 300. I have not tested this, however.

I wrote these instructions with a lot of detail, references and commentary. I hope I don't offend those who just want
a quick guide. If you find typos, facts I got wrong, or things that don't work for you,
please file an issue.

These instructions assume you want to replace Windows with Linux. These instructions do not cover dual
boot. Dual boot is probably possible on these old computers if you install Linux to the
microSD card. I have no idea whether dual boot works well enough to make it worth your effort.

## Credit where credit is due
These instructions are based on the instructions I found [here](https://medium.com/@realzedgoat/a-sorta-beginners-guide-to-installing-ubuntu-linux-on-32-bit-uefi-machines-d39b1d1961ec). It's a good idea to read that document first because it describes the process in more detail and has pictures. The instructions were close but did not quite work. I got a
hint [here](https://unix.stackexchange.com/questions/405472/cannot-find-efi-directory-issue-with-grub-install). The grub-install man page
gave me the rest of the info.

## Why did I do this?
The Lenovo ideacentre Stick 300 has a quad-core Atom processor, 2 GB of RAM and 32GB of eMMC.
It comes with 32-bit Windows 10 Home pre-installed, so I thought I would use it to run the Logitech Media Server.
I hadn't used the PC in a long time time, so I tried to update it. Windows Update is slow, and the eMMC is so
small that after updates completed there was hardly any space left. Also, Windows 10 support is going away soon
and the Stick 300 won't support Windows 11. I thought it is time to install a version of Linux on it. As an
added bonus, the Atom processor supports 64-bit instructions, so installing Linux would give me a 64-bit OS.

I had a T100TA lying around that I wanted to use as a media player, server, and digital picture frame. I wanted
to get rid of 32-bit Windows because Linux support will last a while and Windows support runs out in a few years. That the
[Linux driver for the built-in audio turned out to be broken](#issues-i-had-with-the-t100ta) made me abandon this and reinstall Windows.
I am publishing this information in case you want Linux on your T100TA for other reasons.

## Why Xubuntu 22.04
I already have experience with Ubuntu-based distributions, and Xubuntu Linux is a light(er) weight Linux than
the standard Ubuntu Linux distribution. I like the Xfce desktop, and Xubuntu 22.04 and its successors will hopefully
be supported for a long time.

## Summary of what you will do

0. Back up your computer before you change anything
1. Download Xubuntu 22.04 ISO file and burn it to a flash drive
2. Get into the computer's BIOS and make the changes required to boot from the Linux ISO file in the flash drive
3. Install the Xubuntu image to the computer's eMMC
4. Fix issues booting the Xubuntu image from eMMC

## Back up your computer in case you decide to go back to Windows

Before doing anything else, back up your computer. If you don't have a backup utility,
at the very least copy whatever data you can't live without to external storage and then
create a [Windows Recovery Drive](https://support.microsoft.com/en-us/windows/create-a-recovery-drive-abb4691b-5324-6d4a-8766-73fab304c246#WindowsVersion=Windows_10)
with all the system files on it. With the recovery drive and a lot of work you can restore Windows 10
to where it was in case you decide Xubuntu doesn't work for you and want to go back to Windows.
Creating a Windows Recover Drive was not a fast process. It took my Stick 300 many hours to do this. I do not know why.

## A warning about the Windows Recovery Drive image

After extensive testing, I decided I wanted to put Windows 10 back on my T100TA. My T100TA shipped with Windows 8.1
pre-installed. The Windows 10 upgrade was free. However, Windows 10 created a recovery drive with Windows 8.1 on it
instead of Windows 10. It also reinstalled all of the original versions of Asus utilities and drivers.

Getting Windows 10 back on was a pain. I had to download the Windows 10 ISO image from the Microsoft website,
mount it, run the setup program, and tell it
not to install updates while installing, and then I had to use the Windows Update utility in the Settings to load
updates. It took forever. I also had to remove unwanted Asus utilies and put the latest version of the utilities
I did want. If I had it to do over again I would have burned a full image of eMMC drive using a utility like
[Macrium Reflect](https://www.macrium.com/reflectfree). I have
never tried Macrium Reflect but my web searches always seem to turn that one up.

## Preparing the flash drive 

I used a PC and Rufus to put the Xubuntu 22.04 AMD64 image on a 16GB USB 2.0 flash drive.
The Ubuntu website has a good tutorial [here](https://ubuntu.com/tutorials/create-a-usb-stick-on-windows#1-overview).

This image won't boot on the Stick 300 or the T100TA because the EFI BIOS on those computers require a 32-bit EFI bootloader
and the standard Xubuntu ISO image only includes a 64-bit EFI bootloader. To fix this, get
the file `bootia32.efi` from [here](https://github.com/hirotakaster/baytail-bootia32.efi/blob/master/bootia32.efi)
and copy it to the EFI/boot directory on the flash drive.

## Set up the Stick 300 to boot from a flash drive

1. Connect a USB hub to the Stick 300
2. Connect your mouse, keyboard and flash drive with the Xubuntu image to the hub
3. Connect a monitor to and power to the Stick 300, and power it on.
4. When the Lenovo logo appears, press the `ESC` key repeatedly until it the screen indicates a Hot Key was detected.
5. In the Boot Menu Screen select the `Secure Boot Option` and then set `Enforce Secure Boot` to `Disabled` (see the pictures
in steps 3 & 4 [here](https://support.lenovo.com/us/en/solutions/ht118103-flash-bios-with-uefi-tool-ideacentre-stick-300).
6. Press `F10` to save the changes. The Stick 300 will reboot.
7. When the Lenovo screen shows up, press `F12` to get the boot option. Select the `EFI USB Device`
8. Xubuntu should start to boot.

## Set up the T100TA to boot from a flash drive

1. Plug the T100TA keyboard to your T100TA so you have access to the USB host port.
2. Connect your Xubuntu 22.04 flash drive to the USB port on the T100TA keyboard.
3. Power on the T100TA and watch for the camera LED to come on. You need to hit the `DEL` key or the `F2` key repeatedly
after this light comes on but before the ASUS boot screen appears. It is tricky and takes practice. If your
system just boots to windows, restart your computer and try again.
4. When the BIOS screen appears, use the arrow keys to navigate to the `Security` menu and then select the `Secure Boot Menu`.
Press `Secure Boot Support` and set it to Disabled.
5. Press the `F10` key to `Save and Exit`.
6. Wait for Windows to boot and restart the PC again. 
7. As in step 3, press the `DEL` key or `F2` key at the right time to enter the BIOS menu.
8. When the BIOS screen appears select `Boot`. Then select the `EFI USB Device` as `Boot Option #1`.
9. Press the `F10` key to `Save and Exit`.
10. Xubuntu should start to boot from the flash drive.

## Try Xubuntu 22.04 and then install it

1. You will get a choice to try or install Xubuntu. Select the try option. If you select the install
option, it is more work to fix up the installation.
2. Click the network icon to connect to WiFi. If you have a microSD card installed, make sure you
can access it. Make sure sound is working from HDMI. That is pretty much all the computer can do,
so if it is working, double click the install icon and install it. Make sure to select
install 3rd party drivers and to update while installing.
3. Installation will take a while, especially if your WiFi connection is weak.
4. When installation is complete, you will be prompted to reboot or keep testing. Select keep testing.
You have to manually install the 32-bit Grub bootloader instead of the 64-bit Grub bootloader that got installed.

## Fix the Grub bootloader

What you will do here is write the grub-efi-ia32 bootloader over the 64-bit bootloader installed on the eMMC.
To do that you need to get the latest version of the 32-bit bootloader, mount the EFI partition on the eMMC
because it is not mounted now after Linux installation completed, install the bootloader to the correct
locations, clean up, and do a clean shutdown.

1. Open a terminal window and type `sudo apt update`
2. When the command completes type `sudo apt install grub-efi-ia32-bin`
3. When the command completes type `sudo mount /dev/mmcblk1p1 /mnt`
4. When the command completes type `sudo grub-install --efi-directory=/mnt --boot-directory=/target/boot`
5. When the command completes type `sync`
6. When the command completes type `sudo umount /mnt`
7. When command completes, cleanly shut down the Stick 300 or the T100TA using the GUI. It will take
a long time to shutdown (took me about an hour). I don't know why. Just wait for it to shut down cleanly.
8. Remove the Xubuntu 22.04 flash drive and power back on. The system should boot normally.

## In case you reset your computer before installing the correct Grub bootloader

If you mistakenly skipped the try Xubuntu step and went straight to the install step, or if you choose
reboot instead of keep testing, you don't get a chance to do this procedure. The system will try to boot
the 64-bit grub and will fail. You do not have to reinstall Linux. The code is still there. To recover,
boot Linux again from the flash drive and select try Xubuntu. After Linux boots, open a terminal window
and type the following commands
```
sudo mkdir /target
sudo mount /dev/mmcblk1p2 /target
```
and then follow the steps in the [previous section](#fix-the-grub-bootloader).

## Clean up and update your installation

1. If you are prompted to do so, update the language pack.
2. Run the Software Update tool from the XFCE menu in case there are any updates that didn't get installed
during normal installation.
3. Reboot the computer.
4. Enjoy.

## Issues I had with the T100TA
- The num-lock key is on by default when you first boot up. If you require a password when you log in, when you enter your password,
it likely will fail. Toggle the numlock on the keyboard and type in your password. It should work this time. Once you are logged in
and have verified the num lock setting is off, be sure to go the [Xfce keyboard settings](https://docs.xfce.org/xfce/xfce4-settings/keyboard)
and check the `Restore num lock state on startup` checkbox.

- The built in audio is broken in the Linux Audio system and the SOF project has no plans to fix it. After a few minutes, audio stops
coming out of the speakers or headphones and is replaced by an ear-splitting screeching noise.
See this [issue](https://github.com/thesofproject/sof/issues/3868). The askubuntu site says there is a [fix in
Ubuntu 20.04LTS for the T100HA](https://askubuntu.com/questions/1395617/no-sound-on-asus-transformer-t100ha)
but I never tried it for the T100TA. I found some workarounds that allowed me to get reliable audio from the T100TA,
but my project needed the on-board audio to work:
  - Audio over HDMI works fine (but see the issues I had with HDMI). However, my home theater receivers requires
that the TV is turned on for it to extract audio from HDMI, and my application required it to work when the TV
was off, too.
  - Audio from a USB audio adapter also works fine either through the keyboard's USB host
or through the microUSB charging port with an OTG adapter. My project required the T100TA to hang from the wall
with no keyboard attached so that ruled out the USB host, and it required it to always be powered from external power,
which ruled out the OTG port (none of the OTG hubs I tried would reliably charge the T100TA and work as a hub at the same time).
  - I didn't try Bluetooth audio. That might work but my project required a wired connection to my home theater receiver.

- With an external HDMI monitor connected, the T100TA LCD is off. If you turn it on using the Screen settings or the F8 function key,
the touchscreen touch points are wrong. I fixed it with this script that I set up to run at startup. The comments in the script
explains what it is doing. See the man pages for `xrandr` and `xinput` if you need more information about what those commands do.
This file is saved separately in this project as `fix-lcd-with-hdmi.sh`.

```
#!/bin/bash
# If an external HDMI monitor is connected to the T100TA at boot, this script
# will force on the power of the T100TA's LCD and it will set up the LCD
# as the left hand screen and the HDMI monitor as the right hand screen.

# if HDMI monitor was attached on boot, then the LCD touchscreen will be off
if xrandr --listactivemonitors | grep -q HDMI; then
# the LCD is off, but the system thinks it is on.
# force it off, then force it back on again as the secondary monitor 
  xrandr --output DSI-1 --off
  xrandr --output DSI-1 --auto --left-of HDMI-1

# Now the touchscreen calibration is off. Find the touchscreen ID and
# map it to the LCD (DSI-1)
  TSID=$(xinput --list | grep "ATML1000" | cut -d "=" -f2 | cut -f1)
  if [ $TSID ]; then
    xinput map-to-output $TSID DSI-1
  fi
fi
```
