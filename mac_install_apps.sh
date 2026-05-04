brew update
brew upgrade

packages=(
  zsh
  tmux
  ncdu
  neovim
  neofetch
  mc
  python3
  cmatrix
  hexcurse
  htop
  iperf3
  the_silver_searcher
  exa
  rename
  coreutils
  fzf
  tldr
  sysbench
  macmon
  uv
  lf
  ffmpeg
  glow
  virtualenv
  lnav
  vimfm
  bat
  jq
  yq
  fd
  ripgrep
  delta
  btop
  nnn
  duti
  exiftool
  chafa
  openssh
  libfido2
  mosh
)

for package in "${packages[@]}"; do
  brew install "$package"
done

MOSH_BIN=$(which mosh-server)
MOSH_BINDIR=$(dirname $MOSH_BIN)
echo "export PATH=$PATH:$MOSH_BINDIR" >> ~/.zshenv
