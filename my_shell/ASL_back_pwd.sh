#!/bin/bash
LOCAL_NAME=`pwd`
LOCAL_DATA=`date '+%Y-%m-%d'`
if [ $# == 2 ]; then \
	tar -czvf $1-${LOCAL_DATA}.tar.gz $#; \
else
	echo $LOCAL_NAME;\
	tar -czvf ${LOCAL_NAME}-${LOCAL_DATA}.tar.gz $LOCAL_NAME; \
fi

