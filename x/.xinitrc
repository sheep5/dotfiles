#!/bin/sh

#          _       _ __           
#    _  __(_)___  (_) /___________
#   | |/_/ / __ \/ / __/ ___/ ___/
#  _>  </ / / / / / /_/ /  / /__  
# /_/|_/_/_/ /_/_/\__/_/   \___/  
#
# X server initialization script
#
# Written by Nathanael Putro

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Launch bspwm
exec bspwm
