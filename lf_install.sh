arch=linux-arm64
#arch=linux-amd64
wget "https://github.com/gokcehan/lf/releases/download/r32/lf-$arch.tar.gz"
tar -xf lf-$arch.tar.gz
chmod +x lf
sudo cp lf /usr/local/bin
