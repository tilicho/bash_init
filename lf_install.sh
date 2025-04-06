arch=arm64
#arch=amd64
wgetc "https://github.com/gokcehan/lf/releases/download/r32/lf-linux-$arch.tar.gz"
tar -xf lf-linux-arm64.tar.gz
chmod +x lf
cp lf /usr/local/bin
