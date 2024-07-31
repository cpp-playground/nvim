#!/bin/bash

# Install system dependencies
sudo apt update
sudo apt install git unzip python3-venv

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install node

#Install nvim
sudo snap install nvim --edge --classic

# Install the config
git clone https://github.com/cpp-playground/nvim.git ~/.config/nvim
