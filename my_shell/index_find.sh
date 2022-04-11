#!/bin/bash
####################################################################################
##                        版权所有，作者保留一切权利
## 但保证本程序完整性（包括版权申明，作者信息）的前提下，欢迎任何人对此进行修改传播。
##                     作者邮箱：apostle9891@foxmail.com
##                      欢迎进行交流，请勿用于商业用途
####################################################################################
## 文 件 名: index_find.sh 
## 作    者: apostle --- apostle9891@foxmail.com 
## 版    本: version 1.1
## 日    期: 2014-01-29 10:13
## 描    述: 初始化vim的一些find操作
## 历史描述: 1、[v1.0] find 不能用字符串作为find的参数。
##           2、[v1.1] 解决-a 追加会出现错误的问题,
##	                   解决了当地文件夹下*.h会默认展开的问题			       
####################################################################################
# [目录]
# --行数--- [目录]
# --37----- 1 [知识点用法学习]
# --38-----   1.1 [set 用法学习]
# --64-----   1.2 [eval 用法学习,用于扩展]
# --67----- 2 [字体设置 ]
# --91----- 3 [默认参数设置]
# --106---- 4 [中文help和英文help]
# --136---- 5 [函数设置]
# --137----   5.1 [帮助函数，打印帮助函数]
# --151----   5.2 [解析函数，将输入的参数解析出来]
# --211----   5.3 [调试点1，打印设置的属性]
# --218----   5.4 [打印函数，打印需搜索的路径]
# --226----   5.5 [拼凑函数，分析出的参数转化为find字符串]
# --245----   5.6 [设置find函数，将拼凑的字符串真正设置并执行]
# --257----   5.7 [调试点2，打印find的样子]
# --276---- 6 [程序执行主函数。]

# find ./ \( -iname "amba" -o -iname "Ti" -o -iname ".svn" \) -a -prune -o \( -iname "*.c"  \) -print
#注意：１其中括号一定要要有空格
#      ２其中搜索的文字一定要有双引号，不然会查找错误
####################################################################################
#=@_@=# 知识点用法学习
#=@__@=# set 用法学习
############################################################################
# set指令能设置所使用shell的执行方式，可依照不同的需求来做设置
# 　-a 　标示已修改的变量，以供输出至环境变量。 
# 　-b 　使被中止的后台程序立刻回报执行状态。 
# 　-C 　转向所产生的文件无法覆盖已存在的文件。 
# 　-d 　Shell预设会用杂凑表记忆使用过的指令，
#        以加速指令的执行。使用-d参数可取消。 
# 　-e 　若指令传回值不等于0，则立即退出shell。　　 
# 　-f　 　取消使用通配符。 
# 　-h 　自动记录函数的所在位置。 
# 　-H Shell 　可利用"!"加<指令编号>的方式来执行history中记录的指令。 
# 　-k 　指令所给的参数都会被视为此指令的环境变量。 
# 　-l 　记录for循环的变量名称。 
# 　-m 　使用监视模式。 
# 　-n 　只读取指令，而不实际执行。 
# 　-p 　启动优先顺序模式。 
# 　-P 　启动-P参数后，执行指令时，会以实际的文件或目录来取代符号连接。 
# 　-t 　执行完随后的指令，即退出shell。 
# 　-u 　当执行时使用到未定义过的变量，则显示错误信息。 
# 　-v 　显示shell所读取的输入值。 
# 　-x 　执行指令后，会先显示该指令及所下的参数。 
# 　+<参数> 　取消某个set曾启动的参数。</参数></指令编号>
#   eg:set -f 取消通配符扩展
# 	   set +f 重新设置通配符扩展
############################################################################
#=@__@=# eval 用法学习,用于扩展

####################################################################################
#=@_@=# 字体设置 
COLOR_NORMAL="\033[0m"     # 正常颜色 
COLOR_BLACK="\033[30m"     # 黑色字体
COLOR_RED="\033[31m"       # 红色
COLOR_GREEN="\033[32m"     # 绿色
COLOR_YELLOW="\033[33m"    # 黄色
COLOR_BLUE="\033[34m"      # 蓝色
COLOR_PURPLE="\033[35m"    # 紫色
COLOR_CYAN="\033[36m"      # 青色
COLOR_WHITE="\033[37m"     # 白色

COLOR_BG_BLACK="\033[40m"  # 背景黑色字体
COLOR_BG_RED="\033[41m"    # 背景红色
COLOR_BG_GREEN="\033[42m"  # 背景绿色
COLOR_BG_YELLOW="\033[43m" # 背景黄色
COLOR_BG_BLUE="\033[44m"   # 背景蓝色
COLOR_BG_PURPLE="\033[45m" # 背景紫色
COLOR_BG_CYAN="\033[46m"   # 背景青色
COLOR_BG_WHITE="\033[47m"  # 背景白色
#@__@# echo 例子
# 注：echo -n 不换行输出； echo -n "hello" echo "word" 不会输出成两段
#     echo -e 带颜色输出，并对转义字符进行解释
# echo -e "${COLOR_RED} maohong is a good boy!\n ${COLOR_NORMAL}"
####################################################################################
#=@_@=# 默认参数设置
#可以更改
#例：color1      color
#    -h --help   帮助
ECHO_HELP_COLOR=${COLOR_RED}           # 默认help颜色，即显示颜色
ECHO_HELP_COLOR1=${COLOR_YELLOW}       # 默认help颜色，即显示颜色
DEFALUT_FIND_TYPE="*.c *.h *.cpp *.hh *cc" # 默认find的类型
DEFAULT_APPEND_MODE=0                  # 默认重新建立的搜索,默认为不追加
FIND_SET_PATH=${PWD}                   # 默认find的路径为本地路径
FIND_SET_PATH_NUM=0                    # 设置多个搜索路径
FIND_SET_TYPE=${DEFALUT_FIND_TYPE}     # find的默认搜索类型
FIND_SET_NPATH=".svn"                  # find默认不搜索路径，默认.svn不搜索
FIND_SET_NTYPE=""                      # find默认不搜索文件类型

####################################################################################
#=@_@=# 中文help和英文help
# ECHO_HELP_TITLE=${ECHO_HELP_COLOR}"default build cscope,ctags, \
# 				filenametags index"${COLOR_NORMAL}
# ECHO_HELP_HELP=${ECHO_HELP_COLOR}"it's for user guide"${COLOR_NORMAL}
# ECHO_HELP_CLEAR=${ECHO_HELP_COLOR}"delete and clear the cscope.out, \
# 				cscope.file,filenametags,ctags"${COLOR_NORMAL}
# ECHO_HELP_PATH=${ECHO_HELP_COLOR}"set the search path, default is \$PATH"${COLOR_NORMAL}
# ECHO_HELP_TYPE=${ECHO_HELP_COLOR}"set the find type, default : \
# 				${DEFALUT_FIND_TYPE}"${COLOR_NORMAL}
# ECHO_HELP_NOPATH=${ECHO_HELP_COLOR}"set the no search path"${COLOR_NORMAL}
# ECHO_HELP_NOTYPE=${ECHO_HELP_COLOR}"set the no search type, \
# 					default:${DEFALUT_FIND_TYPE}"${COLOR_NORMAL}
#echo 用中文
ECHO_HELP_DEMO="${COLOR_BG_RED}默认例子：搜索海思球机：index_find.sh -p $PWD -P amba -P ti -t c -t h -P imx138 -P mt9m034 -P ov9712${COLOR_NORMAL}"
ECHO_HELP_TITLE="${ECHO_HELP_COLOR}默认建立 cscope,ctags,filenametags 索引${COLOR_NORMAL}"
ECHO_HELP_HELP="${ECHO_HELP_COLOR}帮助${COLOR_NORMAL}"
ECHO_HELP_CLEAR="${ECHO_HELP_COLOR}清除cscope.out, cscope.file,filenametags,ctags${COLOR_NORMAL}"
ECHO_HELP_PATH="${ECHO_HELP_COLOR}设置搜索路径，默认为当前路径${COLOR_NORMAL}"
ECHO_HELP_TYPE="${ECHO_HELP_COLOR}设置默认搜索类型，默认为:${DEFALUT_FIND_TYPE}${COLOR_NORMAL}"
ECHO_HELP_NOPATH="${ECHO_HELP_COLOR}设置不搜索路径${COLOR_NORMAL}"
ECHO_HELP_NOTYPE="${ECHO_HELP_COLOR}设置不搜索类型,默认为:${DEFALUT_FIND_TYPE}${COLOR_NORMAL}"
ECHO_HELP_APPEND="${ECHO_HELP_COLOR}设置追加功能，即重新建立的搜索结果追加到前搜索中,默认不追加${COLOR_NORMAL}"
# echo -e $ECHO_HELP_TITLE
# echo -e $ECHO_HELP_HELP
# echo -e $ECHO_HELP_CLEAR
# echo -e $ECHO_HELP_PATH
# echo -e $ECHO_HELP_TYPE
# echo -e $ECHO_HELP_NOPATH
# echo -e $ECHO_HELP_NOTYPE
####################################################################################
#=@_@=# 函数设置
#=@__@=# 帮助函数，打印帮助函数
function echo_help()
{
	echo -e "${ECHO_HELP_COLOR1}${ECHO_HELP_DEMO}"
	echo -e "${ECHO_HELP_COLOR1}${ECHO_HELP_TITLE}"
	echo -e "${ECHO_HELP_COLOR1}-h --help    ${ECHO_HELP_HELP}"
	echo -e "${ECHO_HELP_COLOR1}-c --clear   ${ECHO_HELP_CLEAR}"
	echo -e "${ECHO_HELP_COLOR1}-p --path    ${ECHO_HELP_PATH}"
	echo -e "${ECHO_HELP_COLOR1}-t --type    ${ECHO_HELP_TYPE}"
	echo -e "${ECHO_HELP_COLOR1}-P --NPATH   ${ECHO_HELP_NOPATH}"
	echo -e "${ECHO_HELP_COLOR1}-T --NTPYE   ${ECHO_HELP_NOTYPE}"
	echo -e "${ECHO_HELP_COLOR1}-a --append  ${ECHO_HELP_APPEND}"
}
####################################################################################
#=@__@=# 解析函数，将输入的参数解析出来
function getopt_private()
{
	#getopt use
	TEMP=`getopt -o ahcp:t:P:T: --long append,help,clear,path:,type:,NPATH:,NTYPE: \
		  -n 'index_find.sh' -- "$@"`
# 	echo $TEMP
	eval set -- "$TEMP"
	while true ; do
		case "$1" in
			-h|--help)
				echo_help
				exit 1
				shift 1
				;;
			-c|--clear)
				rm -rf apostle_DEBUG
				rm -rf tags cscope.* filenamefile -f
				exit 1
				shift 1
				;;
			-p|--path)
				if [ ${FIND_SET_PATH_NUM} -eq 0 ] ; then
					FIND_SET_PATH="$2"
					FIND_SET_PATH_NUM=$((FIND_SET_PATH_NUM+1))
				else
					FIND_SET_PATH="${FIND_SET_PATH} $2"
				fi
				shift 2
				;;
			-t|--type)
				FIND_SET_TYPE="${FIND_SET_TYPE} *.$2"
				shift 2
				;;
			-P|--NPATH)
				FIND_SET_NPATH="${FIND_SET_NPATH} $2"
				shift 2
				;;
			-T|--NTYPE)
				FIND_SET_NTYPE="${FIND_SET_NTYPE} *.$2"
				shift 2
				;;
			-a|--append)
			    DEFAULT_APPEND_MODE=1
				shift 1
				;;
			--)
				shift
				break
				;;
			*)
				echo -e "index error!\n"
				exit 1
				;;
		esac
	done
}
# echo "Remaining arguments:"
# for arg do echo '--> '"\`$arg'" ; done

#=@__@=# 调试点1，打印设置的属性
# set -f
# echo -e $FIND_SET_TYPE
# echo -e $FIND_SET_NPATH
# echo -e $FIND_SET_NTYPE
# set +f
####################################################################################
#=@__@=# 打印函数，打印需搜索的路径
function print_find_path()
{
	for var in $1 ; do
		echo "the find path is:${var}"
	done
}
####################################################################################
#=@__@=# 拼凑函数，分析出的参数转化为find字符串
TMP=""
function merge_string()
{
	TMP=""
	if [ $# -ge 1 ] ; then
		TMP="\( -iname \"$1\" ";shift
		for i in $@
		do
			TMP="${TMP} -o -iname \"$1\""
			shift
		done
		TMP="${TMP} \)"
	else
		return 1
	fi
		return 0
}
####################################################################################
#=@__@=# 设置find函数，将拼凑的字符串真正设置并执行
function set_find()
{
# 	FIND_STRING="${FIND_SET_PATH} "
	FIND_STRING="$1 "

set -f
	merge_string $FIND_SET_NPATH && FIND_STRING="${FIND_STRING} ${TMP} -a -prune "
	merge_string $FIND_SET_TYPE && FIND_STRING="${FIND_STRING} -o ${TMP} "
	merge_string $FIND_SET_NTYPE && FIND_STRING="${FIND_STRING} ! ${TMP} "
set +f

#=@__@=# 调试点2，打印find的样子
# 	echo ${FIND_STRING}
# 	eval find ${FIND_STRING} -print


	#set cscope
	eval find ${FIND_STRING} -print >> ./apostle_DEBUG/cscope.files
	cscope -bkq -i ./apostle_DEBUG/cscope.files

	#set ctags
	ctags -a `eval find ${FIND_STRING} -print` 

	# generate tag file for lookupfile plugin
	echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/">> ./apostle_DEBUG/filenametags
	eval find ${FIND_STRING} -printf "%f\\\t%p\\\\t1\\\\n" | sort -f >> ./apostle_DEBUG/filenametags
# 	test  -e ./apostle_DEBUG  && mv filenametags cscope.* tags  apostle_DEBUG;cp apostle_DEBUG/tags ./
	test  -e ./apostle_DEBUG  && test -e tags && mv cscope.* apostle_DEBUG;cp tags ./apostle_DEBUG -f
}
####################################################################################
#=@_@=# 程序执行主函数。
#查看输入函数是否合法，假如输入参数为0，则打印帮助
test $# -eq 0  && echo_help && exit
#解析输入参数
getopt_private $@
#打印需要搜索的路径
print_find_path ${FIND_SET_PATH}
#测试是否为追加，不为追加则删除
test ${DEFAULT_APPEND_MODE} -eq 0 && rm apostle_DEBUG -rf;rm tags -f
#测试apostle_DEBUG文件夹是否存在，不存在则建立
test  -e ./apostle_DEBUG  || mkdir apostle_DEBUG
#将拼凑的字符串知己执行
for var in ${FIND_SET_PATH} ; do
	set_find $var
done
####################################################################################
