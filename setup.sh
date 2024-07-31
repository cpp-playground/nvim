#!/bin/bash
# Install system dependencies
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install curl tar git unzip python3-venv build-essential

# Install node JS
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm install node

#Install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >>$HOME/.bashrc

# Install the config
git clone https://github.com/cpp-playground/nvim.git $HOME/.config/nvim
/opt/nvim-linux64/bin/nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
