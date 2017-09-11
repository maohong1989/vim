""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""                        版权所有，作者保留一切权利
"" 但保证本程序完整性（包括版权申明，作者信息）的前提下，欢迎任何人对此进行修改传播。
""                    作者邮箱：apostle9891@foxmail.com
""                     欢迎进行交流，请勿用于商业用途
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" 文 件 名: vimrc
"" 作    者: apostle --- apostle9891@foxmail.com
"" 版    本: version 1.0
"" 日    期: 2013-12-20 12:34
"" 描    述: 对vim的配置信息
"" 历史描述:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [目录]
" --行数--- [目录]
" --42----- 1 [使用的插件列表]
" --65----- 2 [使用的插件导用]
" --66-----   2.1 [emmet.vim 使用规则]
" --78----- 3 [map: 定义默认的映射]
" --79-----   3.1 [映射：映射的基本定义]
" --93----- 4 [快捷键查询]
" --146----   4.1 [映射：映射的基本定义]
" --148----   4.2 [映射：F1-F12映射]
" --158----   4.3 [映射：自定义函数]
" --183----   4.4 [映射：插件函数映射]
" --207----   4.5 [映射：对窗口的操作]
" --219----   4.6 [映射：在命令状态对窗口进行操作]
" --233----   4.7 [映射：窗口缩放移动]
" --248----   4.8 [映射：tab使用]
" --263----   4.9 [映射：自定义录制功能]
" --273----   4.10 [映射：临时]
" --279---- 5 [ab: 定义缩写]
" --297---- 6 [配置：其他插件配置]
" --300----   6.1 [配置：apostle环境变换所配置]
" --326----   6.2 [配置：ctags配置]
" --341----   6.3 [配置：lookupfile配置]
" --371----   6.4 [配置：winmanager配置]
" --385----   6.5 [配置：cscope配置]
" --405---- 7 [基本配置：对vim的各项基本配置]
" --407----   7.1 [基本配置：vim]
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@_@=" 使用的插件列表
" ASL_AutoFunName.vim---------------自定义函数:自动生成函数
" ASL_comments.vim------------------自定义函数:自动注释
" ASL_COMMON.vim--------------------自定义函数:自定义公共函数，包括当下应该设置的注释
" ASL_PRIVATE_FUN.vim---------------自定义函数:自动自身logo
" my_define.vim---------------------自定义函数:自动生成文件头版权设置
" bufexplorer.vim------------------- 插件函数 :打开缓冲的历史文件列表
" conque_term.vim------------------- 插件函数 :可以在vim里打开bash----:conqueterm
" exec_menuitem.vim----------------- 插件函数 :NERD树插件
" fs_menu.vim----------------------- 插件函数 :NERD树插件
" genutils.vim---------------------- 插件函数 :lookupfile依赖的插件
" lookupfile.vim-------------------- 插件函数 :lookupfile插件
" mark.vim-------------------------- 插件函数 :mark插件，标记插件
" mimicpak.vim---------------------- 插件函数 :
" NERD_tree.vim--------------------- 插件函数 :文件树插件NeRD
" Tabular.vim----------------------- 插件函数 :Tab对齐插件
" taglist.vim----------------------- 插件函数 :taglist查看插件
" winfileexplorer.vim--------------- 插件函数 :在窗口管理插件中，左上的文件管理
" winmanager.vim-------------------- 插件函数 :窗口管理插件
" wintagexplorer.vim---------------- 插件函数 :在窗口管理插件中，左下的当前管理
" mathchit.vim---------------------- 插件函数 :用%匹配html
" emmet.vim------------------------- 插件函数 :xml相关插件
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@_@=" 使用的插件导用
""""""""""""""""=@__@=" emmet.vim 使用规则"""""""""""""""""""""""""""""""""
"使用可见效果,输入完毕后ctrl+E
"body>div>ul -------------------------- >  表示子节点
"body>div*3 --------------------------- *  表示多个
"body>div^script ---------------------- ^  表示父节点 
"body>(div+ul)>li --------------------- () 表示每个下面都是
"body>div#nav ------------------------- #  表示id标签
"body>div.main ------------------------ .  表示class
"body>img[user_data="face"] ----------- [] 私有属性
"body>div#loop>li.img_000$*5 ---------- $  计数器，会自动加1
"body>ul>li.img_${my_image_$}*5-------- {} 填充文本
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@_@=" map: 定义默认的映射
""""""""""""""""=@__@=" 映射：映射的基本定义"""""""""""""""""""""""""""""""""
" | command | Normal   | visual     | Operator_pending | insert   | command_line |
" | 命令    | 常规模式 | 可视化模式 | 运算符模式       | 插入模式 | 命令行模式   |
" | :map    | y        | y          | y                | -        | -            |
" | :nmap   | y        | -          | -                | -        | -            |
" | :vmap   | -        | y          | -                | -        | -            |
" | :omap   | -        | -          | y                | -        | -            |
" | :map!   | -        | -          | -                | y        | y            |
" | :imap   | -        | -          | -                | y        | -            |
" | :cmap   | -        | -          | -                | -        | y            |
" | :unmap  |取消映射                                                            |
"
" help map 查看
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@_@=" 快捷键查询
"折叠快捷键
"zc -----> 折叠当前行
"zr -----> 打开折叠行
"zm -----> 关闭折叠行
"zR -----> 打开所有折叠行
"---------------------------------------------
"=@__@=插入代码快捷键
"a ------> 在光标所在位置后一个位置插入
"i ------> 在光标所在位置插入
"I ------> 在光标所在行行首插入
"A ------> 在光标所在行行尾插入
"o ------> 在光标所在行下一行插入
"---------------------------------------------
"=@__@=删除快捷键
"dd -----> 删除该行
"dw -----> 删除该单词
"x  -----> 删除光标所在字符
"--------------------------------------------
"=@__@=移动快捷键
"gg -----> 快速移动到文档第一行
""" -----> 两个上分号，快速移动上上一个位置
"ctrl+G--> 快速移动到文档末尾
"H ------> high，光标移动到屏幕上方
"M ------> middle，光标移动到屏幕中间
"L ------> low, 光标移动到屏幕下方
"--------------------------------------------
"0 ------> 光标快速移动到行首
"$ ------> 光标快速移动到行尾
"--------------------------------------------
"e ------> 光标以单词往后移动
"b ------> 光标以单词往前移动
"E ------> 光标以空格往后移动
"B ------> 光标以空格往前移动
"--------------------------------------------
"ctrl+f -> 以一屏幕为单位往后移动
"ctrl+b -> 以一屏幕为单位往前以后
"ctrl+e -> 光标不动，屏幕往下移动
"ctrl+y -> 光标不动，屏幕往上移动
"--------------------------------------------
"=@__@= 寄存器快捷键
"寄存器快捷键是一种分成有用的使用方式，必须掌握
"它可以让多个数据存不同地方
"
"reg ----> 命令行下使用，可以查看对应的寄存器
"
"visual 模式
"【引号+寄存器+y】--> 将选择的区域存入寄存器
"【引号+寄存器+p】--> 将寄存器的数据copy到光标所在位置
"
"插入模式下
"ctrl+r+寄存器 ----> copy出寄存器内数据
"
""""""""""""""""=@__@=" 映射：映射的基本定义"""""""""""""""""""""""""""""""""

""""""""""""""""=@__@=" 映射：F1-F12映射"""""""""""""""""""""""""""""""""""""
"映射：<F12>: 消除多余的空格
"映射：<F6> : 查找buf缓冲区里已经使用的文件
"映射：<F5> : 已经使用，为lookupfile专用查找
"映射：<F7> : 作为测试用
nmap <F12> :%s/[ \t\r]\+$//g<CR>
nmap <silent> <F6> :LUBufs<cr>
"nmap <F5> <plug>LookupFile<cr>
nmap <F7>  :source ~/.vimrc<cr>:source /mnt/hgfs/share/test.vim<CR>

""""""""""""""""=@__@=" 映射：自定义函数"""""""""""""""""""""""""""""""""""""
"映射：,+: 添加注释，表示此段落为增加，增加自己的logo
"映射：,-: 添加注释，表示此段落为减少 ,增加自己的logo
"映射：,n: 查找自己增加
"映射：,_: 消除自己的logo
"映射：,,: 在多中文本中添加注释
"映射：,x: 在多中文本中消除注释
"映射：,p: 打印目录
"映射：,1: 自动添加注释-全文
"映射：,2: 自动添加注释-区域内
"设置私人vim字库
"映射：c-e: 设置emmet的快捷键
map ,+ :call ASL_AddModifyMark('+')<CR>
map ,- :call ASL_AddModifyMark('-')<CR>
map ,n /++\([_=]\)\@=<CR>
map ,_ :call ASL_CleanMark()<CR>
map <silent> ,, :call ASL_Comment()<CR>
map <silent> ,x :call ASL_UnComment()<CR>
map ,p :call ASL_PrintTable()<CR>
map ,9 :1,$call ASL_DetectFun()<CR>
map ,0 :call ASL_DetectFun()<CR>
" map ,3 :set paste<CR>
let g:PrivateVimFontLib = '/mnt/hgfs/share/PrivateVimFontLib.lib'
let g:user_emmet_leader_key = '<c-a>'

""""""""""""""""=@__@=" 映射：插件函数映射"""""""""""""""""""""""""""""""""""
"映射：,e: Tabular.vim按空格对齐
nmap ,e :Tab /=<CR>
vmap ,e :Tab /=<CR>

"映射：mark.vim中映射，对高亮字符进行查找
nmap \j \*
nmap \k \#

"映射：,z: 保存当前状态，包括折叠和mark标记等状态
nmap ,z :mkview<CR>

"映射：wm: winmanager.vim出现窗口管理
nmap wm :WMToggle<CR>

"映射：cscope的查找
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
"""""""""""""=@__@=" 映射：对窗口的操作"""""""""""""""""""""""""""""""""""""
"映射：对窗口进行左右移动等操作
nmap ,h <C-w>h
nmap ,j <C-w>j
nmap ,k <C-w>k
nmap ,l <C-w>l
nmap ,H <C-w>H
nmap ,J <C-w>J
nmap ,K <C-w>K
nmap ,L <C-w>L
nmap ,w :vs<CR><C-]>

"""""""""""""=@__@=" 映射：在命令状态对窗口进行操作""""""""""""""""""""""""""
"映射：ww: 窗口全屏
"映射：wv: 垂直打开一个窗口
"映射：ws: 横向打开一个窗口
"映射：wc: 关闭一个窗口
"映射：wt: 去最左边的窗口
"映射：wb: 去最右边的窗口
nmap ww :res<CR>:vertical res<CR>
nmap wv <C-w>v
nmap ws <C-w>s
nmap wc <C-w>c
nmap wt <C-w>t
nmap wb <C-w>b

"""""""""""""=@__@=" 映射：窗口缩放移动"""""""""""""""""""""""""""""""""""""""
"映射：wh: 窗口向左放大4个像素
"映射：wj: 窗口向下放大4个像素
"映射：wk: 窗口向上放大4个像素
"映射：wl: 窗口向右放大4个像素
"映射：w=: 窗口相等
"映射：wr: 窗口最高
"映射：wq: 窗口最宽
nmap wh 4<C-w><
nmap wj 4<C-w>-
nmap wk 4<C-w>+
nmap wl 4<C-w>>
nmap w= <C-w>=
"nmap wr <C-w>_
"nmap wq <C-w>|
"""""""""""""=@__@=" 映射：tab使用"""""""""""""""""""""""""""""""""""""
"help tab-page-intro 可查看
" | tabnew    新建标签
" | tabs      显示已经打开标签
" | tabc      关闭当前标签
" | tabn      移动到下一个
" | tabp      移动到上一个
" | tabfirst  移动到第一个
" | tablast   移动到最后一个
nmap <Tab><Tab> :tabn<CR>
" nmap <Tab>n :tabn<CR>
" nmap <Tab>p :tabp<CR>
" nmap <Tab>s :tabs<CR>


"""""""""""""=@__@=" 映射：自定义录制功能"""""""""""""""""""""""""""""""""""""
"映射：对结构体进行打印
"映射：复制并打印字符串
nmap ,r :call Repeat_print()<CR>
vmap ,r :call Repeat_print()<CR>
nmap ,R aprintf("<ESC>"apa is:[%d]\n", <ESC>"apa);<CR><ESC>
nmap ,d :call Mark_print()<CR>

function! Mark_print()

	exe "normal oprintf(\"===========mark fun[%s] len[%d]============\\n\", __FUNCTION__, __LINE__);\<ESC>\<CR>"
endfunction
function! Repeat_print()
	 exe "normal EBvE\"ayiprintf(\"apostle>>>>\<ESC>f=lld$a[%d]\\n\", \<ESC>\"apa);\<ESC>j0"
endfunction

"""""""""""""=@__@=" 映射：临时"""""""""""""""""""""""""""""""""""""""""""""""
"映射：保存当前状态
nmap ,a O<ESC>0i/*<ESC>
nmap ,s o<ESC>0i*/<ESC>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@_@=" ab: 定义缩写
"缩写：定义DEBUG
ab #d #ifdef APOSTLE_DEBUG_PRIMARY<CR>#define DEBUG_PRINT(fmt,arg...) fprintf(stdout, fmt, ##arg)<CR>#define DEBUG_PRIMARY(fmt,arg...) fprintf(stdout, fmt, ##arg)<CR>#define ERROR_PRIMARY(fmt,arg...) fprintf(stdout, fmt, ##arg)<CR>#define ERROR_INFO(error) printf("ERROR:%s[FILE:%s, FUNCTION:%s, LINE:%d]\n",\<CR>error, __FILE__, __FUNCTION__, __LINE__)<CR>#else<CR>#define DEBUG_PRINT(fmt,arg...)<CR>#define DEBUG_PRIMARY(fmt,arg...)<CR>#define ERROR_PRIMARY(fmt,arg...)<CR>#define ERROR_INFO(fmt)<CR>#endif

ab #c #ifdef __cplusplus<CR>#if __cplusplus<CR>extern "C"{<CR>#endif<CR>#endif<CR><CR><CR><CR>#ifdef __cplusplus<CR>#if __cplusplus<CR>}<CR>#endif<CR>#endif
"缩写：对常用错误字符进行纠正
ab enbale enable
ab hanlde handle
ab HANLDE HANDLE
ab widht  width
ab balck  black
ab funciton function
ab __FUNCITON__ __FUNCTION__
ab breka break
ab modlue module
ab defalut default
ab wirte write
ab inculde include
ab szie size

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@_@=" 配置：其他插件配置
"包括：ctags,taglist,lookupfile,winmanager,cscope

"""""""""""""=@__@=" 配置：apostle环境变换所配置""""""""""""""""""""""""""""
"注：此为作者特殊配置，需更改

"配置：打开相应的filenametags
if filereadable("./apostle_DEBUG/filenametags")
	let g:LookupFile_TagExpr = '"./apostle_DEBUG/filenametags"'
endif

" "配置：打开相应的的Session.vim
" "注：Session.vim保存的是当前的会话，即当前在哪些目录，开了哪些窗口
" if filereadable("./apostle_DEBUG/Session.vim")
" 	exe "source ./apostle_DEBUG/Session.vim"
" else
" 	if filereadable("./apostle_DEBUG")
" 		exe "mksession ./apostle_DEBUG/Session.vim"
" 	endif
" endif
"
" "配置：打开相应的的viminfo
" "注：viminfo保存的是一些历史操作。默认在根目录下，但是很容易被其他vim打开刷新
" if filereadable("./apostle_DEBUG/viminfo")
" 	exe "rviminfo ./apostle_DEBUG/viminfo"
" else
" 	exe "wviminfo ./apostle_DEBUG/viminfo"
" endif

"""""""""""""=@__@=" 配置：ctags配置""""""""""""""""""""""""""""""""""""""""
"配置：自动补全ctags功能
set completeopt=longest,menu

"配置：ctags自动载入
set tags+=tags;
set autochdir
set splitright

"配置：只显示一个tags
"配置：假如ctags是最后一个窗口，则关闭
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1

"""""""""""""=@__@=" 配置：lookupfile配置""""""""""""""""""""""""""""""""""
"配置：lookupfile基本配置
let g:LookupFile_MinPatLength = 2               "最少输入2个字符才开始查找
let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
"if filereadable("./filenametags")              "设置tag文件的名字
"	let g:LookupFile_TagExpr = '"./filenametags"'
"endif

" 配置：lookupfile与tags合作
function! LookupFile_IgnoreCaseFunc(pattern)
	let _tags = &tags
	try
		let &tags = eval(g:LookupFile_TagExpr)
		let newpattern = '\c' . a:pattern
		let tags = taglist(newpattern)
	catch
		echohl ErrorMsg | echo "Exception: " . v:exception | echohl NONE
		return ""
	finally
		let &tags = _tags
	endtry
" Show the matches for what is typed so far.
	let files = map(tags, 'v:val["filename"]')
		return files
endfunction
let g:LookupFile_LookupFunc = 'LookupFile_IgnoreCaseFunc'

"""""""""""""=@__@=" 配置：winmanager配置""""""""""""""""""""""""""""""""""
"配置：对窗口进行管理，上边窗口为FileExplorer
"                      下方窗口为TagList,BufExplorer
"注：由于NERDTree插件在关闭文件的时候有bug,故未加入窗口管理
let g:winManagerWindowLayout='FileExplorer|TagList,BufExplorer'
let g:NERDTree_title="NERD Tree"
"let g:winManagerWindowLayout='NERDTree|TagList,BufExplorer'
function! NERDTree_Start()
	    exec 'NERDTree'
endfunction
function! NERDTree_IsValid()
		    return 1
endfunction

"""""""""""""=@__@=" 配置：cscope配置"""""""""""""""""""""""""""""""""""""""
"配置：修改的
if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=1
	set cst
	set nocsverb
	" add any database in current directory
"	if filereadable("cscope.out")
"		cs add cscope.out
"	endif
"
	"配置：打开相应的cscope
	if filereadable("./apostle_DEBUG/cscope.out")
		cs add ./apostle_DEBUG/cscope.out
	endif
	set csverb
endif

"""""""""""""=@__@=" 配置：python配置"""""""""""""""""""""""""""""""""""""""
"安装路径在.vim/systax下
" set filetype=python
" au BufNewFile,BufRead *.py,*.pyw setf python

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@_@=" 基本配置：对vim的各项基本配置

"""""""""""""=@__@=" 基本配置：vim"""""""""""""""""""""""""""""""""""""""
"设置tab替换为相应的空格
"set expandtab
"tab四字节宽
set tabstop=4
"使用退格键可以删除4个空格
set softtabstop=4
"自动缩进4字节
set shiftwidth=4

set wrap
"vim配色
colorscheme desert
"默认用用户自己的键盘
set nocompatible
"高亮开
syntax on
"与windows共享剪贴板
set clipboard+=unnamed
" 在处理未保存或只读文件的时候，弹出确认
set confirm
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"缩进设置"""""""
"使用内置的缩进方法
filetype indent on
"自动缩进
set autoindent
"使用C语言缩进
set cindent
"智能缩进
set smartindent
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"显示行号
set number
"搜索时忽略大小写
set ignorecase
"搜索高亮
set hlsearch
"搜索逐字点亮
set incsearch
"鼠标右键能复制
set mouse=v
"可以再任何时候使用鼠标
set selection=exclusive
set selectmode=mouse,key
"显示匹配括号
set showmatch
set matchtime=5
"当前行横线
set cursorline
"设定光标离窗口5行时窗口自动翻滚
set scrolloff=5
"语法自动折叠
"set foldmethod=syntax
"set foldlevel=100
"编码显示中文
set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8
set encoding=utf-8
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map <silent> ,2 :diffget 2<CR> :diffupdate<CR>
" map <silent> ,3 :diffget 3<CR> :diffupdate<CR>
" map <silent> ,4 :diffget 4<CR> :diffupdate<CR>
