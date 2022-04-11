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
 	let a:Type      = copy(ASL_DetectCommentStype())
	let a:TypeLeft  = a:Type.TypeLeft
	let a:TypeRight = a:Type.TypeRight

	let a:oriline   = a:firstline
	let a:curline   = a:firstline

	call cursor(a:curline-1, 0)
	while 1
		let a:curline = search('^{\s*$', 'W')
		"假如返回为0，则寻找完毕，假如为-1则错误，也有可能寻找到超过最多行从头开始
		if a:curline == 0
			break
		elseif a:curline == -1
			break
		elseif a:curline > a:lastline
			break
		endif

		let a:text = ASL_YesOrNoFun(a:curline)
		if empty(a:text)
			continue
		endif

		if empty(matchlist(getline(a:text[1]-1), repeat(a:TypeLeft, 20)))
			call ASL_CommentFunFromText(a:text[0], a:text[1])
		endif

	endwhile
	call cursor(a:oriline, 0)
endfunction
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" "=@_@=" 去除注释
" function! ASL_RmCommentFun() range
"  	let a:Type      = copy(ASL_DetectCommentStype())
" 	let a:TypeLeft  = a:Type.TypeLeft
" 	let a:TypeRight = a:Type.TypeRight
" 
" 	let a:oriline   = a:firstline
" 	let a:curline   = a:firstline
" 
" 	call cursor(a:curline-1, 0)
" 	while 1
" 		let a:curline = search('^{\s*$', 'W')
" 		if a:curline == 0
" 			break
" 		elseif a:curline == -1
" 			break
" 		elseif a:curline > a:lastline
" 			break
" 		endif
" 
" 		let a:text = ASL_YesOrNoFun(a:curline)
" 		if empty(a:text)
" 			continue
" 		endif
" 
" 		if !empty(matchlist(getline(a:text[1]-1), repeat(a:TypeLeft, 20)))
" 			call ASL_RmCommentFunFromText(a:text[0], a:text[1],a:Type)
" 		endif
" 
" 	endwhile
" 	call cursor(a:oriline, 0)
" endfunction
" function! ASL_RmCommentFunFromText(text, line, Type)
" 	let a:TypeLeft  = a:Type.TypeLeft
" 	let a:TypeRight = a:Type.TypeRight
" 	let a:order = 'g/^.*$/d'
" 	if !empty(matchlist(getline(a:line - 1), '^'.a:TypeLeft.'.*$'))
" 		execute ':sil'.'.'.a:order
" 	endif
" endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@__@=" 检测是否为函数名
"根据匹配模式检测,返回值为[函数名称， 函数行数]
function! ASL_YesOrNoFun(linenum)
	let a:linenum1  = a:linenum - 1
	let a:text1     = getline(a:linenum1)
	let a:ASSIN     = '^\(\s*\)\(.*)\)$'
	let a:ret       = []
	let a:tmp1      = []
	let a:tmp       = matchlist(a:text1, a:ASSIN)
	if empty(a:tmp)
		return []
	else
		let a:ASSIN = '^\(.\+\)\s\+\(.\{-1,}\)\((.*)\)$'
		let a:tmp2  = matchlist(a:text1, a:ASSIN)
		if !empty(a:tmp2)
			let a:ret = insert(a:ret, join(a:tmp2), 0)
			let a:ret = insert(a:ret, a:linenum1, 1)
			return a:ret
		endif

	endif
	call insert(a:tmp1, a:tmp[2], 0)
	
	while 1
		let a:linenum1 = a:linenum1 - 1
		let a:text1    = getline(a:linenum1)
		let a:ASSIN    = '^\(\s*\)\(.*\)\\$'
		let a:tmp      = matchlist(a:text1, a:ASSIN)
		if empty(a:tmp)
			return []
			break
		else
			let a:ASSIN = '^\(.\+\)\s\+\(.\{-1,}\)\((.*\)\\$'
			let a:tmp2  = matchlist(a:text1, a:ASSIN)
			if !empty(a:tmp2)
				call insert(a:tmp1, a:tmp[2], 0)
				break
			endif
		call insert(a:tmp1, a:tmp[2], 0)
		endif
	endwhile

	let a:ret = insert(a:ret, join(a:tmp1), 0)
	let a:ret = insert(a:ret, a:linenum1, 1)

	return a:ret
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@_@=" 主函数,自动添加注释
function! ASL_CommentFun()
	let a:FunText  = getline('.')
	let a:cur_line = line('.')
	call ASL_CommentFunFromText(a:FunText, a:cur_line)
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@__@=" 子函数,根据文字自动添加注释
function! ASL_CommentFunFromText(text, inline)

 	let a:Type          = copy(ASL_DetectCommentStype())
	let a:TypeLeft      = a:Type.TypeLeft
	let a:TypeRight     = a:Type.TypeRight

	"not support the complex comment
	if !empty(a:TypeRight)
		return
	endif

	if exists(g:MAX_CONTENT_WIDTH)
		let a:max_content_width = g:MAX_CONTENT_WIDTH
	else
		let a:max_content_width = 84
	endif

	let a:FunText       = a:text
	let a:FunParamRight = ASL_FlipFun(a:FunText)
	if empty(a:FunParamRight)
		return
	endif
	let a:FunParamLeft   = g:FunParam

	let a:EdgRepeatWidth = a:max_content_width / strlen(a:TypeLeft)

""""""append the param
	let i        = 0
	let cur_line = a:inline + i
	let i        = i + 1
  	call append(cur_line - 1, repeat(a:Type.TypeLeft, a:EdgRepeatWidth))

	let a:RepeatWidth    = strlen(a:TypeLeft) > 1 ? 1 : 2
	let a:TypeLeft       = repeat(a:TypeLeft, a:RepeatWidth)
	let a:TypeLeftWidth  = strlen(a:TypeLeft) + 1

"append the function name
	let a:content = printf("%s%s%s", a:TypeLeft, a:FunParamLeft.FunName,
						   \a:FunParamRight.FunName)
	let cur_line = a:inline + i
	let i        = i + 1
  	call append(cur_line - 1, a:content)

"append the function
	let a:content = printf("%s%s%s", a:TypeLeft, a:FunParamLeft.Function,
						   \get(a:FunParamRight, 'Function'))
	let cur_line =  a:inline + i
	let i        = i + 1
  	call append(cur_line - 1, a:content)

"append the input
	let a:tmp = 0
	for s in a:FunParamRight.InParam
		if a:tmp == 0
			let a:contentleft = printf("%s%s", a:TypeLeft, a:FunParamLeft.InParam)
			let a:tmp         = 1
		else
			let a:contentleft = a:TypeLeft.a:FunParamLeft.FunWidth
		endif

		let a:content = a:contentleft.s

		let cur_line =  a:inline + i
		let i        = i + 1
		call append(cur_line - 1, a:content)
	endfor


"append the return
	let a:tmp = 0
	for s in a:FunParamRight.RetParam
		if a:tmp == 0
			let a:contentleft = printf("%s%s", a:TypeLeft,
							    \a:FunParamLeft.RetParam)
			let a:tmp         = 1
		else
			let a:contentleft = a:TypeLeft.a:FunParamLeft.FunWidth
		endif
		let a:content = a:contentleft.s

		let cur_line =  a:inline + i
		let i        = i + 1
		call append(cur_line - 1, a:content)
	endfor

"append the comment
	let a:content = printf("%s%s%s", a:TypeLeft, a:FunParamLeft.Comment,
						   \'')
	let cur_line =  a:inline + i
	let i        = i + 1
  	call append(cur_line - 1, a:content)

"append the last
	let cur_line =  a:inline + i
	let i        = i + 1
  	call append(cur_line - 1, repeat(a:Type.TypeLeft, a:EdgRepeatWidth))





endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@_@= 分割函数，将文件分割开
function! ASL_FlipFun(FunInList)
	let a:ASSING   = '^\s*\(.\+\)\s\+\(.\{-1,}\)\((.*)\)\s*$'
	let a:FunText  = a:FunInList
	let a:FunList  = matchlist(a:FunText, a:ASSING)

	if empty(a:FunList)
		return
	endif
	let a:FunRet   = a:FunList[1]
	let a:FunName  = a:FunList[2]
	let a:FunInStr = a:FunList[3]

	let a:FunParam = {}

	let a:FunRet   = ASL_RmBrace(a:FunRet)
	let a:FunName  = ASL_RmBrace(a:FunName)
	let a:FunInStr = ASL_RmBrace(a:FunInStr)

	let a:FunParam.FunName  = a:FunName
	let a:FunParam.Function = ASL_AnalysisFunName(a:FunName)
	let a:FunParam.InParam  = ASL_AnalysisInParam(a:FunInStr)
	let a:FunParam.RetParam = ASL_AnalysisFunRet(a:FunRet)
	return a:FunParam

endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@__@=" 函数：去除括号
function! ASL_RmBrace(InParam)

" 	if !empty(matchlist(a:InParam, '^(\s*\(.\{-1,}\)\s*)$'))
	if !empty(matchlist(a:InParam, '^(\s*\(.*\)\s*)$'))
		let a:Tmp    = matchlist(a:InParam, '^(\s*\(.*\)\s*)$')
		let a:FunRet = a:Tmp[1]
	else
		let a:FunRet = a:InParam
	endif
	return a:FunRet
endfunction

"=@__@="函数：循环检测
function! ASL_CirCal(Input, ASSING)
	if empty(a:Input)
		return
	endif
	let a:Ret = []
	let a:tmp = a:Input
" 	while empty(a:tmp)
	while 1
		let a:tmp1 = matchlist(a:tmp, a:ASSING)
		if empty(a:tmp1)
			call add(a:Ret, a:tmp)
			break
		else
			call add(a:Ret, a:tmp1[1])
			let a:tmp = a:tmp1[2]
		endif
	endwhile

	return a:Ret
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@_@=" 分析输入参数
function! ASL_AnalysisInParam(FunInStr)
	let a:Ret = []

	if empty(a:FunInStr)
		let  a:Tmp = "[IN] Null -- 输入为空"
		call add(a:Ret, a:Tmp)
		return a:Ret
	endif

	let a:FunInParam = ASL_CirCal(a:FunInStr, '^\(.\{-}\),\s*\(.*\)\s*$')
	if empty(a:FunInParam)
		return
	endif

"	echo a:FunRet
"	echo a:FunName
"	echo a:FunInParam

" get the len
	let len = 0
	for s in a:FunInParam
		let a:tmp = substitute(s, '^\s*\(.\+\)\s\+\(.\{-}\)$', '\2', '')
		if strlen(a:tmp) > len
			let len = strlen(a:tmp)
		endif
	endfor

	let g:Len1 = g:InLen + len

	for s in a:FunInParam
		let a:tmp = substitute(s, '^\s*\(.\+\)\s\+\(.\{-}\)$', '[\1] \2', '')
		call add(a:Ret, ASL_AddNoteInParam(a:tmp, len))
	endfor

	return a:Ret
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@__@=" 分析参数，并打上记号
function! ASL_AddNoteInParam(FunInStr, len)
	let  a:Ret        = "[IN] Null -- 输入为空"
	let  a:InPutParam = g:InPutParam

	let a:match = matchlist(a:FunInStr, '\[\(.\{-}\)\]\s*\(.*\)')
	if empty(a:match)
		return a:Ret
	endif

"remove pointer
	let a:match[2] = substitute(a:match[2], '\s*\*\(.*\)$', '\1', '')
	let a:match[1] = substitute(a:match[1], '\s*\*\(.*\)$', '\1', '')

	let a:param1    = '[IN]'
	let a:param2    = a:match[2]
	let a:param3    = ' -- '
	let a:param4    = a:match[1]
	let a:lenparam1 = g:InLen

" if strlen less than 8, write xxxx
	if strlen(a:param4) < 8
		let a:param4 = 'xxxx'
	endif

	for key in keys(a:InPutParam)
		if !empty(matchlist(a:match[2], key))
			let a:param4 = a:InPutParam[key]
			if key == 'output'
				let a:param1    = '[OUT]'
			endif
			break
		endif
	endfor

	let a:Ret = printf("%-*s%-*s%s%s", a:lenparam1, a:param1, a:len, a:param2,
				\a:param3, a:param4)

	return a:Ret
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@_@=" 分析函数名字
function! ASL_AnalysisFunName(FunName)
	let a:LocalTable  = g:FunName
	let a:ret         = 'xxxx'
	let a:LocalInPram = a:FunName

	for key in keys(a:LocalTable)
		if !empty(matchlist(a:LocalInPram, key))
			let a:ret = a:LocalTable[key]
			break
		endif
	endfor

	return a:ret
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@_@=" 分析函数返回值
function! ASL_AnalysisFunRet(FunRet)
	let a:LocalTable  = g:ReturnParam
	let a:ret         = []
	let a:LocalInPram = a:FunRet
	let a:tmp         = []
	for key in keys(a:LocalTable)
		if !empty(matchlist(a:LocalInPram, key))

			let a:tmp = a:LocalTable[key]
			break

		endif
	endfor

"lookup
	if !empty(a:tmp)
		if len(a:tmp) == 1
			let a:ret = a:tmp
		else
			let a:i = 0
			while a:i < len(a:tmp)
				let a:param1 = a:tmp[a:i]
				let a:i = a:i + 1
				let a:param2 = ' -- '
				let a:param3 = a:tmp[a:i]
				let a:i = a:i + 1

				let a:lenparam1 = g:Len1
				let a:tmp1 = printf("%-*s%s%s", a:lenparam1, a:param1,
							\a:param2, a:param3)
				call add(a:ret, a:tmp1)
			endwhile

		endif
	endif

	if empty(a:ret)
		let a:ret = ['xxxx']
	endif
	return a:ret
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
