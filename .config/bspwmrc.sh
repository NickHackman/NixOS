#! /bin/sh

###############################################################
# START UP
###############################################################
feh --bg-scale /etc/nixos/backgrounds/desktop.jpg &
polybar main -c /etc/nixos/.config/polybar.ini &
sxhkd &
picom &
blueman-applet &
xbindkeys -f /etc/nixos/.config/xbindkeysrc

###############################################################
# CONFIGURATION
###############################################################
bspc monitor -d I II III IV V VI VII VIII IX X

bspc config border_width         2
bspc config window_gap          10
bspc config focused_border_color \#7B873C
bspc config split_ratio          0.50
bspc config borderless_monocle   true
bspc config gapless_monocle      true

###############################################################
# RULES
###############################################################
bspc rule -a Emacs desktop='^1' state=tiled follow=on
bspc rule -a "Google-chrome" desktop='^2' state=tiled follow=on
bspc rule -a TelegramDesktop desktop='^3' state=tiled follow=on
bspc rule -a zoom desktop='^5' state=tiled follow=on
bspc rule -a Gimp desktop='^8' state=floating follow=on
