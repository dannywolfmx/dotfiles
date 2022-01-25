#!/bin/bash
sudo apt install wget curl


#
# Get the laster golang release
GO_PACKAGE_INSTALLER="$(curl https://go.dev/VERSION?m=text)".linux-amd64.tar.gz
FILE_GO_PACKAGE=/tmp/$GO_PACKAGE_INSTALLER
[ -e $FILE_GO_PACKAGE ] && rm $FILE_GO_PACKAGE
#
#
# Get The golang package
wget "https://dl.google.com/go/$GO_PACKAGE_INSTALLER" -O $FILE_GO_PACKAGE
#
# "Install" golang in the system
[ ! -d $HOME/workspace ] && mkdir $HOME/workspace
sudo rm -rf $HOME/workspace/go && tar -C $HOME/workspace -xzf $FILE_GO_PACKAGE
export GOPATH=$HOME/workspace/go
export GOBIN=$HOME/workspace/go/bin
export PATH=$PATH:$GOBIN

go install golang.org/x/tools/gopls@latest
