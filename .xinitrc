# Disable access control for the current user.
#xhost +SI:localuser:$USER

# Make Java applications aware this is a non-reparenting window manager.
#export _JAVA_AWT_WM_NONREPARENTING=1

# Set default cursor.
xsetroot -cursor_name left_ptr

# Set keyboard repeat rate.
xset r rate 200 60

# Uncomment the following block to use the exwm-xim module.
#export XMODIFIERS=@im=exwm-xim
#export GTK_IM_MODULE=xim
#export QT_IM_MODULE=xim
#export CLUTTER_IM_MODULE=ximXKGXK

# Finally start Emacs
#xrandr --output eDP-1 --scale 0.5x0.5
#Modeline "2560x1080_60.00"  230.76  2560 2728 3000 3440  1080 1081 1084 1118  -HSync +Vsync
# xrandr --newmode "2560x1080_60.00"  230.76  2560 2728 3000 3440  1080 1081 1084 1118  -HSync +Vsync
# xrandr --addmode HDMI-1 "2560x1080_60.00"
# xrandr --output eDP-1 --scale 0.5x0.5 --pos 0x0 --output HDMI-1 --mode "2560x1080_60.00" --above eDP-1
xset b off
/home/yottanami/bin/multiscreen.sh
setxkbmap -layout us,ir;setxkbmap -option 'grp:alt_shift_toggle'
setxkbmap -option ctrl:swapcaps
export FG42_V3=true
exec fg42-wm
#xinput set-prop 14 'libinput Accel Speed' 1
