#!/usr/bin/env bash

polybar-msg cmd quit 2>/dev/null
killall -q polybar

while pgrep -x polybar >/dev/null; do
    sleep 0.2
done

for monitor in $(xrandr --query | awk '$2 == "connected" {print $1}'); do
    MONITOR="$monitor" polybar main -c ~/.config/polybar/config.ini &
done
