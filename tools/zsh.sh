#!/bin/bash
#Vendor
#install 
echo "Installing zsh"
#fedora or redhat like
rpm -qa | grep -qw zsh || 
if ! rpm -qa | grep -qw zsh; then
	sudo dnf install zsh
elif ! dpkg -l | grep -qw zsh; then
	sudo apt install zsh
else
	echo "Error on detect vendor (dnf | apt) to install zsh"
	exit 1;
fi;

echo "Installing oh my zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
