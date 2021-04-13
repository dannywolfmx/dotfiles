#!/bin/bash

#Ask to install emacs
echo -n "Install emacs? [Y/n]"
read answer 
if [ "$answer" != "${answer#[Yy]}"]
	#Run install emacs
	. $PWD/emacs/install.sh 
fi

echo -n "Install Go? [Y/n]"
read answer 
if [ "$answer" != "${answer#[Yy]}"]
	#Run install golang
	. $PWD/tools/golang.sh
fi

#.bashrc
rm $HOME/.bashrc
ln -s $PWD/.bashrc $HOME/.bashrc
rm $HOME/.profile
ln -s $PWD/.profile $HOME/.profile
