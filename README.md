# How to set up Xubuntu 22.04 on the Lenovo ideacentre Stick 300 or the Asus T100TA

## Normal caveats with step-by-step guide
These instructions work today. They are probably only good for a few months. The instructions work equally well
for the Lenovo ideacentre Stick 300 and the T100TA.

## Credit where credit is due
These instructions are based on the instructions I found [here](https://medium.com/@realzedgoat/a-sorta-beginners-guide-to-installing-ubuntu-linux-on-32-bit-uefi-machines-d39b1d1961ec). It's a good idea to read that document first because it describes the process in more detail and has pictures. The instructions were close but did not quite work. I got a
hint [here](https://unix.stackexchange.com/questions/405472/cannot-find-efi-directory-issue-with-grub-install). The grub-install man page
gave me the rest of the info.

## Why did I do this?
The Lenovo ideacentre Stick 300 has a quad-core Atom processor, 2 GB of RAM and 32GB of eMMC.
It comes with 32-bit Windows 10 Home pre-installed, so I thought I would use it to run the Logitech Media Server.
I hadn't used the PC in a long time time, so I tried to update it. Windows Update is slow, and the eMMC is so
small that after updates completed there was hardly any space left. Also, Windows 10 is support is going away soon
and the Stick 300 won't support Windows 11. I thought it is time to install a version of Linux on it. As an
added bonus, the Atom processor supports 64-bit instructions, so installing Linux would give me a 64-bit OS.

I had a T100TA lying around that I wanted to use as a media player, server, and digital picture frame. I wanted
to get rid of 32-bit Windows because Linux support will last a while and Windows support runs out in a few years. That the
[built-in audio turned out to be broken](#issues-i-had-with-the-t100ta) made me abandon this and reinstall Windows. I am publishing this information
in case you want Linux on your T100TA for other reasons.

## Why Xubuntu 22.04
I already have experience with Ubuntu-based distributions, and Xubuntu Linux is a light(er) weight Linux than
the standard Ubuntu Linux distribution. I like the Xfce desktop, and Xubuntu 22.04 and its successors will hopefully
be supported for a long time.

## Problems to solve

1. Download Xubuntu 22.04 ISO file and burn it to a flash drive
2. Figure out how to make the Stick 300 boot from a flash drive
3. Install the Xubuntu image to eMMC
4. Debug issues booting the Xubuntu image from eMMC

## Back up your computer in case you decide to go back to Windows

Before doing anything else, back up your Stick 300 and create a [Windows Recovery Drive](https://support.microsoft.com/en-us/windows/create-a-recovery-drive-abb4691b-5324-6d4a-8766-73fab304c246#WindowsVersion=Windows_10)
with all the system files on it in case this doesn't work for you. Create the Windows Recovery Drive overnight
because it takes many hours for some reason. Dual boot is possible with this if you put a microSD card
in the slot, but since getting rid of Windows is my goal, I didn't set it up that way and have never tested it.

## A warning about the T100TA Windows Recovery Drive Image

My T100TA came with Windows 8.1 pre-installed, so the recovery drive put Windows 8.1 on the T100TA instead of Windows 10
like I had before. Getting Windows 10 back on was a pain. I had to download the Windows 10 ISO image from the Microsoft
website, mount it, run the setup program, and tell it not to install updates while installing, and then I had to use the
Windows Update utility in the Settings to load updates. It took forever. If I had it to do over again I would have
burned a full image of eMMC drive using a utility like [Macrium Reflect](https://www.macrium.com/reflectfree). I have
never tried Macrium Reflect but my web searches always seem to turn that one up.

## Preparing the flash drive 

I used a PC and Rufus to put the Xubuntu 22.04 AMD64 image on an old 16GB USB 2.0 flash drive.
The Ubuntu website has a good tutorial [here](https://ubuntu.com/tutorials/create-a-usb-stick-on-windows#1-overview).

This image won't boot on the Stick 300 because the Stick 300 requires a 32-bit UEFI bootloader
and the standard Xubuntu ISO image assumes a 64-bit UEFI bootloader. To fix this, get
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
8. When the BIOS screen appears select `Boot`. Then select the `EFI USB Device` as Boot Option #1.
9. Press the `F10` key to `Save and Exit`.
10. Xubuntu should start to boot from the flash drive.

## Try Xubuntu 22.04 and then install it.

1. You will get a choice to try or install Xubuntu. Select the try option. If you select the install
option, it is more work to fix up the installation.
2. Click the network icon to connect to WiFi. If you have a microSD card installed, make sure you
can access it. Make sure sound is working from HDMI. That is pretty much all the computer can do,
so if it is working, double click the install icon and install it. Make sure to select
install 3rd party drivers and to update while installing.
3. Installation will take a while, especially if your WiFi connection is weak.
4. When installation is complete, you will be prompted to reboot or keep testing. Select keep testing.
You have to manually the 32-bit Grub bootloader instead of the 64-bit Grub bootloader that got installed.

## Fix the Grub bootloader.

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

## Clean up and update your installation

1. If you are prompted to do so, update the language pack.
2. Run the Software Update tool from the XFCE menu in case there are any updates that didn't get installed
during normal installation.
3. Reboot the computer.
4. Enjoy.

## Issues I had with the T100TA
- The num-lock key is on by default when you first boot up. If you require a password when you log in, when you enter your password,
it likely will fail. Toggle the numlock on the keyboard and it will work again.

- The built in audio is broken in the Linux Audio system and the SOF project has no plans to fix it. After a few minutes, audio stops
coming out of the speakers or headphones and is replaced by an ear-splitting screeching noise.
See this [issue](https://github.com/thesofproject/sof/issues/3868). The askubuntu site says there is a [fix in
Ubuntu 20.04LTS](https://askubuntu.com/questions/1395617/no-sound-on-asus-transformer-t100ha) but I never tried it.
Workarounds exist, but did not work for my application:
  - Audio over HDMI works fine. 
  - Audio from a USB to audio adapter also works fine either through the keyboard's USB host
or through the microUSB charging port with an OTG adapter.
  - I didn't try Bluetooth audio but that also might work.

- With an external HDMI monitor connected, the T100TA LCD is off. If you turn it on using the Screen settings or the F8 function key,
the touchscreen touch points are wrong. I fixed it with this script that I set up to run at startup
```
#!/bin/bash

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
#    echo "TSID=$TSID"
    xinput map-to-output $TSID DSI-1
#  else
#    echo "Touchscreen ID not found"
  fi

#else
#  echo "nothing to fix"
fi
```
