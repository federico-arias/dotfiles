/home/federico/.pcloudapp &
synclient TapButton1=1
synclient TapButton2=3
#xrandr --output HDMI1 --primary --mode 1920x1080 --output LVDS1   --mode 1366x768 --below HDMI1
setxkbmap -option grp:win_space_toggle latam,ru
xsetroot -solid "#262524"
sleep 30
conky -a top_left -d &
