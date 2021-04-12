#!/bin/bash
#Run install emacs
. $PWD/emacs/install.sh 
. $PWD/tools/golang.sh
#.bashrc
rm $HOME/.bashrc
ln -s $PWD/.bashrc $HOME/.bashrc
rm $HOME/.profile
ln -s $PWD/.profile $HOME/.profile
