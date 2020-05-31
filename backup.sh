OPTIONS=(
   --exclude="/dev/"
   --exclude="/proc/"
   --exclude="/sys/"
   --exclude="/tmp/"
   --exclude="/run/"
   --exclude="/mnt/"
   --exclude="/media/"
   --exclude="/lost+found/"
   --exclude="/var/"
    --recursive
    --partial
    --progress
    -avz
)


userName=$1
hostName=$2
outDir="/Volumes/etc/backup"
mkdir "$outDir/$hostname"
rsync  "${OPTIONS[@]}" "$userName@$hostName:/" "$outDir/hostname/"

