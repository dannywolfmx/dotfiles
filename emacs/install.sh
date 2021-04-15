#!/bin/bash

#Set the current script directory
#https://stackoverflow.com/questions/59895/how-can-i-get-the-source-directory-of-a-bash-script-from-within-the-script-itsel
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
#Delete .emacs.d
[ -e $HOME/.emacs.d ] && rm -rf $HOME/.emacs.d
#install doom
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
#If doom already exist delete
[ -e $HOME/.doom.d ] && rm -r $HOME/.doom.d
#soft link from the current (PWD) doom.d directory, to the home directory
ln -s $DIR/.doom.d $HOME/.doom.d

#sync to doom
$HOME/.emacs.d/bin/doom sync
