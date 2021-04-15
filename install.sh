#!/bin/bash

#Ask to install emacs
echo -n "Install emacs? [Y/n] "
read answer 
if [ "$answer" != "${answer#[Yy]}" ]
then
	#Run install emacs
	. $PWD/emacs/install.sh 
fi

echo -n "Install Go? [Y/n] "
read answer 
if [ "$answer" != "${answer#[Yy]}" ]
then
	#Run install golang
	. $PWD/tools/golang.sh
fi

#.bashrc
BASHRC_FILE=$HOME/.bashrc
if test -f "$BASHRC_FILE";
then
	echo -n "A .bashrc file detected, do you want to overwrite it? [Y/n] "
	read answer
	if [ "$answer" != "${answer#[Yy]}" ]
	then
		rm $BASHRC_FILE
		ln -s $PWD/.bashrc $BASHRC_FILE
	else
		echo "Ok the link to .bashrc will not be applied"
	fi
else
	#Link the bashrc
	ln -s $PWD/.bashrc $BASHRC_FILE
fi
#.profile
PROFILE_FILE=$HOME/.profile
if test -f "$PROFILE_FILE";
then
	echo -n "A .profile file detected, do you want to overwrite it? [Y/n] "
	read answer
	if [ "$answer" != "${answer#[Yy]}" ]
	then
		rm $HOME/.profile
		ln -s $PWD/.profile $PROFILE_FILE
	else
		echo "Ok the link to .profile will not be applied"
	fi
else
	#Link the profile
	ln -s $PWD/.profile $PROFILE_FILE
fi
