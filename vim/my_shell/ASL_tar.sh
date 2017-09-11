#!/bin/bash
LOCAL_DATA=`date '+%Y-%m-%d'`
if [ $# == 1 ]; then \
	tar -czvf $1-${LOCAL_DATA}.tar.gz $1; \
else
	echo -n "no dir\n"; \
fi

