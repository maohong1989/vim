#!/bin/bash
LOCAL_DATA=`date '+%Y-%m-%d'`
cp .vimrc .vim/vimrc
tar -czvf vim-back${LOCAL_DATA}.tar.gz .vim; \
