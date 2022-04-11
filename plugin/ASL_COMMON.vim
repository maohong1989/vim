"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""                        版权所有，作者保留一切权利
"" 但保证本程序完整性（包括版权申明，作者信息）的前提下，欢迎任何人对此进行修改传播
"" 作者邮箱：apostle9891@foxmail.com，欢迎进行交流，请勿用于商业用途
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" 文 件 名: ASL_PRIVATE_FUN.vim
"" 作    者: apostle --- apostle9891@foxmail.com
"" 版    本: version 1.0
"" 日    期: 2013-11-17 11:06
"" 描    述:
"" 历史描述:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [目录]
" --行数--- [目录]
" --21----- [定义一些全局变量                                                        "]
" --30----- [定义默认的map]
" --39----- [自动检测当前的文件状态。并自动寻找到注释]
" --52----- [函数：强制设置当前注释方式]
" --70----- [函数：检测当前文件需用什么注释]
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"++=" 定义一些全局变量                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:MY_AUTHOR         = 'apostle'
let g:MY_EMAIL          = 'apostle9891@foxmail.com'
let g:MY_LOGO           = 'apostle ['.strftime('%Y-%m-%d %H:%M').']'
let g:MAX_CONTENT_WIDTH = 90
let g:TAB_LEN           = 4
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@_@=" 定义默认的map
map ,+ :call ASL_AddModifyMark('+')<CR>     "注释
map ,- :call ASL_AddModifyMark('-')<CR>
map ,n /++\([_=]\)\@=<CR>
map ,_ :call ASL_CleanMark()<CR>
"tmp
" nmap ,o :call Add_title()<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"++=" 自动检测当前的文件状态。并自动寻找到注释
command! -nargs=1 ForceSetStype call ASL_ForceSetStype (<f-args>)
"default is #
let g:NoteType = {
\      'c'   : '//', 
\      'h'   : '//', 
\      'hh'  : '//', 
\      'hpp' : '//', 
\      'cpp' : '//', 
\      'vim' : '"' , 
\      'xml' : "<!-- @ -->",
\      'html': "<!-- @ -->",
\      'vimrc': '"',
\}

let g:GlobalFileType = {'flag':0, 'type':'#'}

"++=" 函数：强制设置当前注释方式
function! ASL_ForceSetStype(stype)
	let g:GlobalFileType.flag = 1
	let g:GlobalFileType.type = a:stype

	if exists('b:FileType')
		unlet b:FileType
	endif

	if exists('b:Comment')
		unlet b:Comment
	endif

	if exists('b:UnComment')
		unlet b:UnComment
	endif
endfunction

"++=" 函数：检测当前文件需用什么注释
function! ASL_DetectCommentStype()
	if exists('b:FileType')
		return {'TypeIndex':b:TypeIndex, 'TypeLeft':b:TypeLeftParam,
					\ 'TypeRight':b:TypeRightParam} 
	else
		let b:FileType = '#'
	endif

	if g:GlobalFileType.flag == 1
		let b:FileType     = g:GlobalFileType.type
	else
		let l:comment_name = expand("%")
		let l:suffix       = substitute(l:comment_name, '^.*\.', '', 'g')
		let b:FileType     = get(g:NoteType, l:suffix, '#')
	endif

	let ASSING = '^\(.\{-}\)\s*\(@\)\s*\(.*\)'
	let l:list = matchlist(b:FileType, ASSING)
	if empty(l:list)
		let b:TypeIndex      = 1
		let b:TypeLeftParam  = b:FileType 
		let b:TypeRightParam = '' 
	else 
		let b:TypeIndex      = 2
		let b:TypeLeftParam  = copy(l:list[1])
		let b:TypeRightParam = copy(l:list[3])
	endif
 	return {'TypeIndex':b:TypeIndex, 'TypeLeft':b:TypeLeftParam,
 				\ 'TypeRight':b:TypeRightParam}
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
