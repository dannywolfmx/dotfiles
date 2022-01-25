#!/bin/bash
#Vendor
sudo apt install curl
#install 
echo "Installing zsh"
#fedora or redhat like
if [ -n "$(command -v dnf)" ]; then
	sudo dnf install zsh
elif [ -n "$(command -v apt)" ]; then
	sudo apt install zsh
else
	echo "Error on detect vendor (dnf | apt) to install zsh"
	exit 1;
fi;

echo "Installing oh my zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
