#!/bin/sh

killall -w thunar stalonetray xfce4-power-manager

xsetroot -solid LightSteelBlue4
thunar --daemon&
stalonetray&
xfce4-power-manager&
