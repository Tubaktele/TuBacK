#!/usr/bin/env bash
cd $HOME/tuback
rm -rf $HOME/.telegram-cli
install() {
rm -rf $HOME/.telegram-cli
sudo chmod +x tg
chmod +x tuback
chmod +x ts
./ts
}
if [ "$1" = "ins" ]; then
install
fi
chmod +x install
lua start.lua
