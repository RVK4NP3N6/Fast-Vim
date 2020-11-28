#!/bin/bash
if [ ! -d "~/.vim" ]; then
    cp -rf ./.vim ~
else
    cp -rf ./.vim ~/.vimbak
    cp -rf ./.vim ~
fi

#判断文件是否存在
if [[ ! -f "~/.vimrc" ]]; then
    cp -rf ./.vimrc ~/.vimrc
else
    cp ~/.vimrc ~/.vimrc.bak
	echo "vimrc文件存在，备份至.vimrc.bak"    
fi
echo "All Done"

