#!/bin/bash
#Run install emacs
. $PWD/emacs/install.sh 
. $PWD/tools/golang.sh
#.bashrc
ln -s $PWD/.bashrc $HOME/.bashrc
ln -s $PWD/.profile $HOME/.profile
