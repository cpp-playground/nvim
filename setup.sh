#!/bin/bash

# Install system dependencies
sudo apt update
sudo apt install curl tar git unzip python3-venv

# Install node JS
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.bashrc
nvm install node

#Install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >>~/.bashrc

# Install the config
git clone https://github.com/cpp-playground/nvim.git ~/.config/nvim
