#!/bin/sh
apt-get update
apt-get upgrade


PACKAGES="git zsh tmux ncdu neovim neofetch mc ncdu python3 cmatrix hexcurse htop iperf3 silversearcher-ag exa rename coreutils fzf tldr lf sysbench avahi-daemon avahi-utils w3m lnav vimfm curl wget lynx nnn"

for pkg in $PACKAGES; do
  echo "Installing $pkg..."
  if apt install -y "$pkg"; then
    echo "Success: $pkg"
  else
    echo "Failed: $pkg"
  fi
done
