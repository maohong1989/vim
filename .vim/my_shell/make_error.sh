#!/bin/sh
	make $* 2>&1 | tee log_make 
	cat log_make | grep -E 'error|warning|错误|Error|Warning' -n --color=auto 
	rm log_make

