"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""                        版权所有，作者保留一切权利
"" 但保证本程序完整性（包括版权申明，作者信息）的前提下，欢迎任何人对此进行修改传播
"" 作者邮箱：apostle9891@foxmail.com，欢迎进行交流，请勿用于商业用途
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" 文 件 名: ASL_PRIVATE_FUN.vim
"" 作    者: apostle --- apostle9891@foxmail.com
"" 版    本: version 1.0
"" 日    期: 2013-11-17 11:06
"" 描    述: 此函数主要是为了进行自动函数申明
"" 历史描述:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [目录]
" --行数--- [目录]
" --26----- 1 [全局结构体参数]
" --76----- 2 [主函数，检测是否为函数名]
" --152---- 3 [主函数,自动添加注释]
" --159----   3.1 [子函数,根据文字自动添加注释]
" --276----   3.2 [函数：去除括号]
" --289----   3.3 [函数：循环检测]
" --311---- 4 [分析输入参数]
" --349----   4.1 [分析参数，并打上记号]
" --391---- 5 [分析函数名字]
" --407---- 6 [分析函数返回值]
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map ,o :call ASL_CommentFun()<CR>
" map ,o :call ASL_DetectFun()<CR>
"=@_@=" 全局结构体参数
let g:InLen    = 5
let g:FunParam = {
\       'FunWidth' : '           ',
\		'FunName'  : ' 函 数 名: ',
\		'Function' : ' 功    能:',
\		'InParam'  : ' 参    数:',
\		'RetParam' : ' 返 回 值: ',
\		'Comment'  : ' 说    明: ',
\}

let g:InPutParam = {
			\ 'handle' : '模块句柄',
			\ 'input'  : '输入参数',
			\ 'ninput' : '输入参数长度',
			\ 'output' : '输出参数',
			\ 'poutlen': '输出参数长度',
			\ 'len'    : '结构体长度',
			\ 'cmd'    : '命令参数',
\}

" let g:ReturnType  = [
" 			\'COMMON_OK',  '成功',
" 			\'标准错误码', '失败',
" \]

let g:ReturnType  = [
			\'COM_SUCCESS', '成功',
			\'COM_ERROR', '失败',
\]
let g:ReturnParam = {
			\ 'Uint32' : g:ReturnType,
			\ 'Sint32' : g:ReturnType,
			\ 'HB_S32' : g:ReturnType,
			\ 'HB_U32' : g:ReturnType,
			\ 'int'    : g:ReturnType,
			\ 'void'   : ['NULL'],
\}

let g:FunName = {
			\ 'init'    : '模块初始化',
			\ 'create'  : '模块创建',
			\ 'exit'    : '模块退出',
			\ 'open'    : '模块打开',
			\ 'start'   : '模块开始',
			\ 'stop'    : '模块结束',
			\ 'ioctrl'  : '模块控制',
			\ 'get'     : '获取参数',
			\ 'set'     : '设置参数',
			\ 'callback': '回调函数',
\}

let g:Len1 = 5
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@_@=" 主函数，检测是否为函数名
function! ASL_DetectFun() range
 	let l:Type      = copy(ASL_DetectCommentStype())
	let l:TypeLeft  = l:Type.TypeLeft
	let l:TypeRight = l:Type.TypeRight

	let l:oriline   = l:firstline
	let l:curline   = l:firstline

	call cursor(l:curline-1, 0)
	while 1
		let l:curline = search('^{\s*$', 'W')
		"假如返回为0，则寻找完毕，假如为-1则错误，也有可能寻找到超过最多行从头开始
		if l:curline == 0
			break
		elseif l:curline == -1
			break
		elseif l:curline > l:lastline
			break
		endif

		let l:text = ASL_YesOrNoFun(l:curline)
		if empty(l:text)
			continue
		endif

		if empty(matchlist(getline(l:text[1]-1), repeat(l:TypeLeft, 20)))
			call ASL_CommentFunFromText(l:text[0], l:text[1])
		endif

	endwhile
	call cursor(l:oriline, 0)
endfunction
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" "=@_@=" 去除注释
" function! ASL_RmCommentFun() range
"  	let l:Type      = copy(ASL_DetectCommentStype())
" 	let l:TypeLeft  = l:Type.TypeLeft
" 	let l:TypeRight = l:Type.TypeRight
" 
" 	let l:oriline   = l:firstline
" 	let l:curline   = l:firstline
" 
" 	call cursor(l:curline-1, 0)
" 	while 1
" 		let l:curline = search('^{\s*$', 'W')
" 		if l:curline == 0
" 			break
" 		elseif l:curline == -1
" 			break
" 		elseif l:curline > l:lastline
" 			break
" 		endif
" 
" 		let l:text = ASL_YesOrNoFun(l:curline)
" 		if empty(l:text)
" 			continue
" 		endif
" 
" 		if !empty(matchlist(getline(l:text[1]-1), repeat(l:TypeLeft, 20)))
" 			call ASL_RmCommentFunFromText(l:text[0], l:text[1],l:Type)
" 		endif
" 
" 	endwhile
" 	call cursor(l:oriline, 0)
" endfunction
" function! ASL_RmCommentFunFromText(text, line, Type)
" 	let l:TypeLeft  = l:Type.TypeLeft
" 	let l:TypeRight = l:Type.TypeRight
" 	let l:order = 'g/^.*$/d'
" 	if !empty(matchlist(getline(l:line - 1), '^'.l:TypeLeft.'.*$'))
" 		execute ':sil'.'.'.l:order
" 	endif
" endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@__@=" 检测是否为函数名
"根据匹配模式检测,返回值为[函数名称， 函数行数]
function! ASL_YesOrNoFun(linenum)
	let l:linenum1  = a:linenum - 1
	let l:text1     = getline(l:linenum1)
	let l:ASSIN     = '^\(\s*\)\(.*)\)$'
	let l:ret       = []
	let l:tmp1      = []
	let l:tmp       = matchlist(l:text1, l:ASSIN)
	if empty(l:tmp)
		return []
	else
		let l:ASSIN = '^\(.\+\)\s\+\(.\{-1,}\)\((.*)\)$'
		let l:tmp2  = matchlist(l:text1, l:ASSIN)
		if !empty(l:tmp2)
			let l:ret = insert(l:ret, join(l:tmp2), 0)
			let l:ret = insert(l:ret, l:linenum1, 1)
			return l:ret
		endif

	endif
	call insert(l:tmp1, l:tmp[2], 0)
	
	while 1
		let l:linenum1 = l:linenum1 - 1
		let l:text1    = getline(l:linenum1)
		let l:ASSIN    = '^\(\s*\)\(.*\)\\$'
		let l:tmp      = matchlist(l:text1, l:ASSIN)
		if empty(l:tmp)
			return []
			break
		else
			let l:ASSIN = '^\(.\+\)\s\+\(.\{-1,}\)\((.*\)\\$'
			let l:tmp2  = matchlist(l:text1, l:ASSIN)
			if !empty(l:tmp2)
				call insert(l:tmp1, l:tmp[2], 0)
				break
			endif
		call insert(l:tmp1, l:tmp[2], 0)
		endif
	endwhile

	let l:ret = insert(l:ret, join(l:tmp1), 0)
	let l:ret = insert(l:ret, l:linenum1, 1)

	return l:ret
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@_@=" 主函数,自动添加注释
function! ASL_CommentFun()
	let l:FunText  = getline('.')
	let l:cur_line = line('.')
	call ASL_CommentFunFromText(l:FunText, l:cur_line)
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@__@=" 子函数,根据文字自动添加注释
function! ASL_CommentFunFromText(text, inline)

 	let l:Type          = copy(ASL_DetectCommentStype())
	let l:TypeLeft      = l:Type.TypeLeft
	let l:TypeRight     = l:Type.TypeRight

	"not support the complex comment
	if !empty(l:TypeRight)
		return
	endif

	if exists(g:MAX_CONTENT_WIDTH)
		let l:max_content_width = g:MAX_CONTENT_WIDTH
	else
		let l:max_content_width = 84
	endif

	let l:FunText       = l:text
	let l:FunParamRight = ASL_FlipFun(l:FunText)
	if empty(l:FunParamRight)
		return
	endif
	let l:FunParamLeft   = g:FunParam

	let l:EdgRepeatWidth = l:max_content_width / strlen(l:TypeLeft)

""""""append the param
	let i        = 0
	let cur_line = l:inline + i
	let i        = i + 1
  	call append(cur_line - 1, repeat(l:Type.TypeLeft, l:EdgRepeatWidth))

	let l:RepeatWidth    = strlen(l:TypeLeft) > 1 ? 1 : 2
	let l:TypeLeft       = repeat(l:TypeLeft, l:RepeatWidth)
	let l:TypeLeftWidth  = strlen(l:TypeLeft) + 1

"append the function name
	let l:content = printf("%s%s%s", l:TypeLeft, l:FunParamLeft.FunName,
						   \l:FunParamRight.FunName)
	let cur_line = l:inline + i
	let i        = i + 1
  	call append(cur_line - 1, l:content)

"append the function
	let l:content = printf("%s%s%s", l:TypeLeft, l:FunParamLeft.Function,
						   \get(l:FunParamRight, 'Function'))
	let cur_line =  l:inline + i
	let i        = i + 1
  	call append(cur_line - 1, l:content)

"append the input
	let l:tmp = 0
	for s in l:FunParamRight.InParam
		if l:tmp == 0
			let l:contentleft = printf("%s%s", l:TypeLeft, l:FunParamLeft.InParam)
			let l:tmp         = 1
		else
			let l:contentleft = l:TypeLeft.l:FunParamLeft.FunWidth
		endif

		let l:content = l:contentleft.s

		let cur_line =  l:inline + i
		let i        = i + 1
		call append(cur_line - 1, l:content)
	endfor


"append the return
	let l:tmp = 0
	for s in l:FunParamRight.RetParam
		if l:tmp == 0
			let l:contentleft = printf("%s%s", l:TypeLeft,
							    \l:FunParamLeft.RetParam)
			let l:tmp         = 1
		else
			let l:contentleft = l:TypeLeft.l:FunParamLeft.FunWidth
		endif
		let l:content = l:contentleft.s

		let cur_line =  l:inline + i
		let i        = i + 1
		call append(cur_line - 1, l:content)
	endfor

"append the comment
	let l:content = printf("%s%s%s", l:TypeLeft, l:FunParamLeft.Comment,
						   \'')
	let cur_line =  l:inline + i
	let i        = i + 1
  	call append(cur_line - 1, l:content)

"append the last
	let cur_line =  l:inline + i
	let i        = i + 1
  	call append(cur_line - 1, repeat(l:Type.TypeLeft, l:EdgRepeatWidth))





endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@_@= 分割函数，将文件分割开
function! ASL_FlipFun(FunInList)
	let l:ASSING   = '^\s*\(.\+\)\s\+\(.\{-1,}\)\((.*)\)\s*$'
	let l:FunText  = a:FunInList
	let l:FunList  = matchlist(l:FunText, l:ASSING)

	if empty(l:FunList)
		return
	endif
	let l:FunRet   = l:FunList[1]
	let l:FunName  = l:FunList[2]
	let l:FunInStr = l:FunList[3]

	let l:FunParam = {}

	let l:FunRet   = ASL_RmBrace(l:FunRet)
	let l:FunName  = ASL_RmBrace(l:FunName)
	let l:FunInStr = ASL_RmBrace(l:FunInStr)

	let l:FunParam.FunName  = l:FunName
	let l:FunParam.Function = ASL_AnalysisFunName(l:FunName)
	let l:FunParam.InParam  = ASL_AnalysisInParam(l:FunInStr)
	let l:FunParam.RetParam = ASL_AnalysisFunRet(l:FunRet)
	return l:FunParam

endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@__@=" 函数：去除括号
function! ASL_RmBrace(InParam)

" 	if !empty(matchlist(a:InParam, '^(\s*\(.\{-1,}\)\s*)$'))
	if !empty(matchlist(a:InParam, '^(\s*\(.*\)\s*)$'))
		let l:Tmp    = matchlist(a:InParam, '^(\s*\(.*\)\s*)$')
		let l:FunRet = l:Tmp[1]
	else
		let l:FunRet = l:InParam
	endif
	return l:FunRet
endfunction

"=@__@="函数：循环检测
function! ASL_CirCal(Input, ASSING)
	if empty(a:Input)
		return
	endif
	let l:Ret = []
	let l:tmp = a:Input
" 	while empty(l:tmp)
	while 1
		let l:tmp1 = matchlist(l:tmp, a:ASSING)
		if empty(l:tmp1)
			call add(l:Ret, l:tmp)
			break
		else
			call add(l:Ret, l:tmp1[1])
			let l:tmp = l:tmp1[2]
		endif
	endwhile

	return l:Ret
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@_@=" 分析输入参数
function! ASL_AnalysisInParam(FunInStr)
	let l:Ret = []

	if empty(a:FunInStr)
		let  l:Tmp = "[IN] Null -- 输入为空"
		call add(l:Ret, l:Tmp)
		return l:Ret
	endif

	let l:FunInParam = ASL_CirCal(l:FunInStr, '^\(.\{-}\),\s*\(.*\)\s*$')
	if empty(l:FunInParam)
		return
	endif

"	echo l:FunRet
"	echo l:FunName
"	echo l:FunInParam

" get the len
	let len = 0
	for s in l:FunInParam
		let l:tmp = substitute(s, '^\s*\(.\+\)\s\+\(.\{-}\)$', '\2', '')
		if strlen(l:tmp) > len
			let len = strlen(l:tmp)
		endif
	endfor

	let g:Len1 = g:InLen + len

	for s in l:FunInParam
		let l:tmp = substitute(s, '^\s*\(.\+\)\s\+\(.\{-}\)$', '[\1] \2', '')
		call add(l:Ret, ASL_AddNoteInParam(l:tmp, len))
	endfor

	return l:Ret
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@__@=" 分析参数，并打上记号
function! ASL_AddNoteInParam(FunInStr, len)
	let  l:Ret        = "[IN] Null -- 输入为空"
	let  l:InPutParam = g:InPutParam

	let l:match = matchlist(a:FunInStr, '\[\(.\{-}\)\]\s*\(.*\)')
	if empty(l:match)
		return l:Ret
	endif

"remove pointer
	let l:match[2] = substitute(l:match[2], '\s*\*\(.*\)$', '\1', '')
	let l:match[1] = substitute(l:match[1], '\s*\*\(.*\)$', '\1', '')

	let l:param1    = '[IN]'
	let l:param2    = l:match[2]
	let l:param3    = ' -- '
	let l:param4    = l:match[1]
	let l:lenparam1 = g:InLen

" if strlen less than 8, write xxxx
	if strlen(l:param4) < 8
		let l:param4 = 'xxxx'
	endif

	for key in keys(l:InPutParam)
		if !empty(matchlist(l:match[2], key))
			let l:param4 = l:InPutParam[key]
			if key == 'output'
				let l:param1    = '[OUT]'
			endif
			break
		endif
	endfor

	let l:Ret = printf("%-*s%-*s%s%s", l:lenparam1, l:param1, l:len, l:param2,
				\l:param3, l:param4)

	return l:Ret
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@_@=" 分析函数名字
function! ASL_AnalysisFunName(FunName)
	let l:LocalTable  = g:FunName
	let l:ret         = 'xxxx'
	let l:LocalInPram = a:FunName

	for key in keys(l:LocalTable)
		if !empty(matchlist(l:LocalInPram, key))
			let l:ret = l:LocalTable[key]
			break
		endif
	endfor

	return l:ret
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@_@=" 分析函数返回值
function! ASL_AnalysisFunRet(FunRet)
	let l:LocalTable  = g:ReturnParam
	let l:ret         = []
	let l:LocalInPram = a:FunRet
	let l:tmp         = []
	for key in keys(l:LocalTable)
		if !empty(matchlist(l:LocalInPram, key))

			let l:tmp = l:LocalTable[key]
			break

		endif
	endfor

"lookup
	if !empty(l:tmp)
		if len(l:tmp) == 1
			let l:ret = l:tmp
		else
			let l:i = 0
			while l:i < len(l:tmp)
				let l:param1 = l:tmp[l:i]
				let l:i = l:i + 1
				let l:param2 = ' -- '
				let l:param3 = l:tmp[l:i]
				let l:i = l:i + 1

				let l:lenparam1 = g:Len1
				let l:tmp1 = printf("%-*s%s%s", l:lenparam1, l:param1,
							\l:param2, l:param3)
				call add(l:ret, l:tmp1)
			endwhile

		endif
	endif

	if empty(l:ret)
		let l:ret = ['xxxx']
	endif
	return l:ret
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
