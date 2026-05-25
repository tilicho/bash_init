#!/usr/bin/env bash
set -euo pipefail

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


if [[ $# -ne 2 ]]; then
    echo "usage: $0 user host" >&2
    exit 2
fi

userName=$1
hostName=$2
outDir="/Volumes/etc/backup"
targetDir="$outDir/$hostName"

mkdir -p "$targetDir"
rsync "${OPTIONS[@]}" "$userName@$hostName:/" "$targetDir/"
