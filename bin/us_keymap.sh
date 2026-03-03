#!/bin/bash

sed -i s/\"gb\"/\"us\(altgr-intl\)\"/ ~/.config/sway/config 
swaymsg reload
