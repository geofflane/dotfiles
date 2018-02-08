#!/bin/sh

color0=$(xrdb -query -all | grep "*.color0" | sed "s/\*\.color0:\t//")
color1=$(xrdb -query -all | grep "*.color1" | sed "s/\*\.color1:\t//")
color2=$(xrdb -query -all | grep "*.color2" | sed "s/\*\.color2:\t//")
color3=$(xrdb -query -all | grep "*.color3" | sed "s/\*\.color3:\t//")
color4=$(xrdb -query -all | grep "*.color4" | sed "s/\*\.color4:\t//")
color5=$(xrdb -query -all | grep "*.color5" | sed "s/\*\.color5:\t//")
color6=$(xrdb -query -all | grep "*.color6" | sed "s/\*\.color6:\t//")
color7=$(xrdb -query -all | grep "*.color7" | sed "s/\*\.color7:\t//")
color8=$(xrdb -query -all | grep "*.color8" | sed "s/\*\.color8:\t//")

~/.config/lemonbar/lemonbarshow.sh | lemonbar -a 20 -B $color0 -F $color7 -f "DejaVu Sans Mono for Powerline:size=6" -g x20 -p | sh
