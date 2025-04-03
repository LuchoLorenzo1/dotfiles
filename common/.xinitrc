#!/bin/sh

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

export PATH=$HOME/.local/bin:$HOME/go/bin:$PATH

# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS="@im=fcitx"
# export LC_CTYPE="ja_JP.UTF-8"

# export LD_LIBRARY_PATH=/usr/lib/

wallpaper &
setxkbmap -option caps:escape &
xrandr --output DisplayPort-1 --primary --mode 1920x1080 --rate 240.00 --output DisplayPort-2 --mode 1920x1080 --rate 240.00 --right-of DisplayPort-1 --output DVI-D-0 --mode 1920x1080 --rate 144.00 --left-of DisplayPort-1 &
redshift -l -34:-58 -t 5000:2000 &
picom &
# udiskie -t &
# cbatticon &
# nm-applet &
# fcitx -d &

exec qtile start
