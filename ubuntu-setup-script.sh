#!/bin/bash

# Ubuntuシステムアップデート
sudo apt update && sudo apt upgrade -y

# 必要なパッケージのインストール
sudo apt install -y curl wget gpg apt-transport-https ca-certificates gnupg lsb-release

# Docker Desktopのインストール
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER

# VSCodeのインストール
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code

# Google Chromeのインストール
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt install -f -y

# Zoomのインストール
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo apt install -y ./zoom_amd64.deb

# Dropboxのインストール
sudo apt install -y nautilus-dropbox

# Discordのインストール
wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo dpkg -i discord.deb
sudo apt install -f -y

# VLCのインストール
sudo apt install -y vlc

# Thunderbirdのインストール
sudo apt install -y thunderbird

# Slackのインストール
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.29.149-amd64.deb
sudo dpkg -i slack-desktop-*.deb
sudo apt install -f -y

# nanoのインストール
sudo apt install -y nano

# 1Passwordのインストール
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | sudo tee /etc/apt/sources.list.d/1password.list
sudo apt update && sudo apt install -y 1password

# 添付スクリプトの実行
chmod +x vscode-laravel-extensions-installer.sh
./vscode-laravel-extensions-installer.sh

chmod +x oh-my-zsh-plugin-installer.sh
./oh-my-zsh-plugin-installer.sh

echo "Ubuntu環境のセットアップが完了しました。システムを再起動してください。"
