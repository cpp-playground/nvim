# Instalation

> [!WARNING]  
> This neovim configuration depends on [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) for some parts of its UI. If you're using it from the terminal, you'll need to set up your terminal font accordingly.
> The Windows installation setup the Hack Nerd font, but the Linux one leaves you on your own. 


## Linux
To install this neovim configuration on Ubuntu, simply run:
```bash
wget -O - https://raw.githubusercontent.com/cpp-playground/nvim/master/setup.sh | bash
```

> [!NOTE]
> The plugins used by this config require a fairly modern version of Neovim. Sometimes, the snap version isn't "new" enough.
> If you prefer to manually install the config, simply install all the dependencies (git unzip python3-venv) and neovim manually
> then clone this repository as `~/.config/nvim` (Which can be done with the following command: `git clone git@github.com:cpp-playground/nvim.git ~/.config/nvim`)
