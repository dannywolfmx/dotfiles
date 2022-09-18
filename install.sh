link (){
    #echo $1 $2 $3 $4

    # Check if the file or dir already exist
    if test $1 $3; then
         echo -n " A $4 detected, do you want to overwrite it? [Y/n] "
         read answer
         if [ "$answer" != "${answer#[Nn]}" ]; then
           echo "Skipped \n"
           return 0
         fi
    fi

    #Link the profile
    rm $3 -rf
    echo -n "Linking the $4 \n"
    ln -s $2 $3
    return 0
}

PROFILE_FILE=$HOME/.profile
link -f $PWD/.profile $PROFILE_FILE ".profile file"

BASHFILE=$HOME/.bashrc
link -f $PWD/.bash $BASHFILE ".bashrc file"

ZSHRC_FILE=$HOME/.zshrc
link -f $PWD/.zshrc $ZSHRC_FILE ".zshrc file"

DOOM_DIR=$HOME/.doom.d
link -d $PWD/emacs/.doom.d $DOOM_DIR ".doom.d DIR"
