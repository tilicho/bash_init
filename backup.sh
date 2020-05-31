OPTIONS=(
   --exclude="/dev/"
   --exclude="/proc/"
   --exclude="/sys/"
   --exclude="/tmp/"
   --exclude="/run/"
   --exclude="/mnt/"
   --exclude="/media/"
   --exclude="/lost+found/"
   --exclude="/home/pi/nexmon/"
   --exclude="/var/"
    --recursive
    --partial
    --progress
    -avz
)

rsync  "${OPTIONS[@]}" "/" "ser@lostbook.local:/Volumes/OS/pi/"

