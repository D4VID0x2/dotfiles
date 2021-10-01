#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

#echo "---" | tee -a /tmp/polybar.log 

#for MON in $(xrandr -q | grep " connected" | cut -d ' ' -f1); do
    #MONITOR=$MON polybar mybar 2>&1 | tee -a "/tmp/polybar$MON.log" & disown
#done

#MONITOR="eDP1" polybar mybar 2>&1 | tee -a "/tmp/polybar.log" & disown

polybar primarybar 2>&1 | tee -a "/tmp/polybar.log" & disown
polybar secondarybar 2>&1 | tee -a "/tmp/polybarHDMI.log" & disown

echo "Bars launched..."
