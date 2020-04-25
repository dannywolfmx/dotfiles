#!/bin/bash

# Update

sudo apt update

# git,  wget, zsh, stow install
## git : administrar repositorios
## wget: descargar configuracion de oh-my-zsh
## zsh: sustituir bash
## stow, enlaces simbolicos para dotfiles

sudo apt install wget git zsh stow -y

##Font to oh-my-zsh theme
sudo apt install fonts-powerline -y

##Vim compatibility to nvim
sudo apt install python3-pip -y
pip3 install --user pynvim

#Fzf search to vim install
sudo apt install fzf	


#Install dotfile
cd ~/
rm dotfiles -rf
rm .zshrc
rm .bashrc
rm .vimrc
rm .vim -rf
rm -rf ~/.oh-my-zsh


function install {

  git clone git@github.com:dannywolfmx/dotfiles.git

  # enlace simbolico del contenido de la carpeta
  cd ~/dotfiles


  stow ubuntu


  #Download vimrc
  git clone --recurse-submodules -j8 git@github.com:dannywolfmx/vimrc.git
  stow vimrc

  # Set zsh by default
  chsh -s $(which zsh)


  #APLICAR CAMBIOS EN EL SHELL SIN REINICIAR
  source ~/.zshrc
}


# Set ZSH default shell
# Prevent zsh autoexecute with "RUNZSH=no CHSH=no"
RUNZSH=no CHSH=no sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && install




