#!/bin/bash

sed -i s/\"us\(altgr-intl\)\"/\"gb\"/ ~/.config/sway/config 
swaymsg reload
