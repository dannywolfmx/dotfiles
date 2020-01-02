#!/usr/bin/env sh


#Preguntar al sistema que escritorio estoy usando
desktop=$(echo $DESKTOP_SESSION)

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

case $desktop in
    i3)
    if type "xrandr" > /dev/null; then
        for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
            MONITOR=$m polybar --reload main -c ~/.config/polybar/config &
        done
    else
        polybar main -c ~/.config/polybar/config &
    fi;;
esac



