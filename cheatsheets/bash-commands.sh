df -h #disk space
sudo dd if=/home/federico/.torrents/debian-live-8.4.0-i386-mate-desktop.iso of=/dev/sdb bs=4M; sync # iso image to bootable linux usb
synclient TapButton1=1 #touchpad mouse click
mimeopen -d some_file.png #set default application
zip -r examples.zip *.png #zip all files into file examples compress
#monitor resolution dual screen
xrandr --output HDMI1 --primary --mode 1920x1080 \
	--output LVDS1 --mode 1366x768 --right-of HDMI1 
setxkbmap latam #set keyboard mapping 
xbacklight -set 100 # brightness   
pactl set-sink-volume 0 150%
sudo ifup ra0 # set interface 0 up
sudo modprobe module # activate kernel module
lsblk # list all connected devices
sudo mount /dev/sdb1 $HOME/volume
sudo umount /dev/sdb1
sudo iwconfig scan
#substitutes "foo" with "bar" in file 'baz.txt'
sed -i "s/foo/bar/m" baz.txt
setxkbmap -option grp:win_space_toggle latam,ru # use W-space to toggle between keyboard layouts
# ffmpeg
# imagemagick
convert -resize 50% image-file.jpg
