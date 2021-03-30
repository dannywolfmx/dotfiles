#!/bin/bash

#Set the current script directory
#https://stackoverflow.com/questions/59895/how-can-i-get-the-source-directory-of-a-bash-script-from-within-the-script-itsel
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
#If doom already exist delete
[ -e $HOME/.doom.d ] && rm -r $HOME/.doom.d
#soft link from the current (PWD) doom.d directory, to the home directory
ln -s $DIR/.doom.d $HOME/.doom.d
