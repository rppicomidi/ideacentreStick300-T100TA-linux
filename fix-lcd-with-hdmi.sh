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
