#!/bin/bash
#备份.vim文件
if [ ! -d "~/.vim" ]; then
    cp -rf ./.vim ~
else
    cp -rf ./.vim ~/.vimbak
    cp -rf ./.vim ~
fi

#备份.vimrc文件并替换
if [[ ! -f "~/.vimrc" ]]; then
    cp -rf ./.vimrc ~/.vimrc
else
    cp ~/.vimrc ~/.vimrc.bak
    cp -rf ./.vimrc ~/.vimrc
fi
echo "All Done"

