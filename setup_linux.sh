sh install_apps.sh
sh vim_install.sh
cp .* ../
chsh -s /bin/zsh

curl -v --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install git-delta

env CGO_ENABLED=0 go install -trimpath -ldflags="-s -w" github.com/gokcehan/lf@latest
