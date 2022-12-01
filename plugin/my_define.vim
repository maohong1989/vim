" user can modify
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ContentWidth   = 84 
"add the titlecopyright width, solve the chinese strlen no sure, the width
"equal strlen(g:TitleCopyRight)
let g:TitleParam      = {
			\   'TitleCopyRight' : {
			\   'Width':
			\   '                                                                                  ',
			\   'Param':[
			\   '                       版权所有，作者保留一切权利                                 ',
			\   '在保证本程序完整性（包括版权申明，作者信息）的前提下，欢迎任何人对此进行修改传播。',
			\   '作者邮箱：apostle9891@foxmail.com，欢迎进行交流，请勿用于商业用途                 ',
			\],
			\	'ModifyFlag':[
			\    1,
			\    1,
			\    1,
			\],
			\},
			\	'TitleParamLeft' : {
			\   'Width'          : '          ',
			\   'Param'          :{
			\   '1_FileName'     : '文 件 名: ',
			\   '2_Author'       : '作    者: ',
			\   '3_Verstion'     : '版    本: ',
			\   '4_Date'         : '日    期: ',
			\   '5_Description'  : '描    述: ',
			\   '6_LastModified' : '历史描述: ',
			\},
			\},
			\   'TitleParamRight' : {
			\   'Width'          : '          ',
			\   'Param'          :{
			\   '1_FileName'     : expand('%') ,
			\   '2_Author'       : 'apostle --- apostle9891@foxmail.com',
			\   '3_Verstion'     : 'version 1.0',
			\   '4_Date'         : strftime('%Y-%m-%d %H:%M'),
			\   '5_Description'  : '',
			\   '6_LastModified' : '',
			\}
			\},
			\   'TitleParamFlag' : {
			\   '1_FileName'     : 1,
			\   '2_Author'       : 1,
			\   '3_Verstion'     : 1,
			\   '4_Date'         : 1,
			\   '5_Description'  : 1,
			\   '6_LastModified' : 1,
			\},
			\   'TitleParamIndex': [
			\   '1_FileName'     ,
			\   '2_Author'       ,
			\   '3_Verstion'     ,
			\   '4_Date'         ,
			\   '5_Description'  ,
			\   '6_LastModified' ,
			\],
\}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! Add_title()
	let LineNum          = 0
 	let l:Type           = copy(ASL_DetectCommentStype())

	call DetectTitleExist(l:Type)

	let l:TypeLeft       = l:Type.TypeLeft
	let l:TypeRight      = l:Type.TypeRight
" 	let l:TypeRight      = '//'
	let l:EdgRepeatWidth = g:ContentWidth / strlen(l:TypeLeft)

	let l:RepeatWidth    = strlen(l:TypeLeft) > 1 ? 1 : 2
	let l:TypeLeft       = repeat(l:TypeLeft, l:RepeatWidth)

	let l:TypeLeftWidth  = strlen(l:TypeLeft) + 1
	let l:ContentWidth   = strlen(g:TitleParam.TitleCopyRight.Width)
	let l:TypeRightWidth = g:ContentWidth - l:ContentWidth - l:TypeLeftWidth

	"add the edgings
  	call append(LineNum, repeat(l:Type.TypeLeft, l:EdgRepeatWidth))
	let LineNum = LineNum + 1

	"add the copyright
	for param in g:TitleParam.TitleCopyRight.Param
" 	for param in len(TitleParam.TitleCopyRight.Param)
		let l:Content        = param
		let l:newline        = printf("%-*s%-*s%*s",
								\l:TypeLeftWidth, l:TypeLeft,
								\l:ContentWidth, l:Content, l:TypeRightWidth, l:TypeRight)
" 		if g:TitleParam.TitleCopyRight.ModifyFlag[] == 1
			call append(LineNum, l:newline)
" 		else
" 			call setline(LineNum + 1, l:newline)
" 		endif
		let LineNum = LineNum + 1
	endfor

	"add the edgings
  	call append(LineNum, repeat(l:Type.TypeLeft, l:EdgRepeatWidth))
	let LineNum = LineNum + 1

	"add the TitleParam information
" 	let l:TypeLeftWidth  = strlen(l:TypeLeft) * l:RepeatWidth  + 1
" 	let l:ContentWidth   = strlen(g:TitleParam.TitleParamLeft.Width)
" 	let l:ContentWidth   = strlen(g:TitleParam.TitleCopyRight.Width)
" 	let l:TypeRightWidth = g:ContentWidth - l:ContentWidth - l:TypeLeftWidth
	for Param in sort(keys(g:TitleParam.TitleParamLeft.Param))
		"solve the problem the title type error,because when enter document, call expand('%'),the value is sure
		if Param == '1_FileName'
			let l:Content = get(g:TitleParam.TitleParamLeft.Param, Param, '?????')
						  \. expand('%')
	    else
			let l:Content = get(g:TitleParam.TitleParamLeft.Param, Param, '?????')
						  \. get(g:TitleParam.TitleParamRight.Param, Param, '?????')
	    endif
		let l:Content = printf("%-*s", l:ContentWidth, l:Content)
		let l:newline        = printf("%-*s%-*s%*s",
								\l:TypeLeftWidth, l:TypeLeft,
								\l:ContentWidth, l:Content, l:TypeRightWidth, l:TypeRight)
		call append(LineNum, l:newline)
		let LineNum = LineNum + 1
	endfor

	"add the edgings
  	call append(LineNum, repeat(l:Type.TypeLeft, l:EdgRepeatWidth))
	let LineNum = LineNum + 1
endfunction


function! Comment_set_Block(comment, ...)
let l:with = l:0 >= 1 ? a:1 : strlen(a:comment)+2
return repeat("//", 30)
endfunction

function! DetectTitleExist(Type)

	let l:TypeLeft = a:Type.TypeLeft
	let ASSING      = '^\%(' .l:TypeLeft. '\)\@!'

	let l:LastLine = 1
 	call cursor(1,0)
	let l:LastLine  = search(ASSING, 'nW') - 1
	let l:LineNum   = 1
	let l:StartLine = 1

	if l:LastLine < 0
		let	l:LastLine = 1
	endif

	let l:index      = 0
	let l:TitleIndex = 0
	for curline in getline(l:StartLine, l:LastLine)

		if l:index < len(g:TitleParam.TitleCopyRight.Param)
			if match(curline, g:TitleParam.TitleCopyRight.Param[l:index]) >= 0
				let	g:TitleParam.TitleCopyRight.ModifyFlag[l:index] = 0
				let l:index = l:index + 1
			endif
		endif

		if l:TitleIndex < len(g:TitleParam.TitleParamIndex)
			let l:IndexText = g:TitleParam.TitleParamIndex[l:TitleIndex]
			if match(curline, g:TitleParam.TitleParamLeft.Param[l:IndexText])>= 0
				let g:TitleParam.TitleParamFlag[l:IndexText] = 0
				let l:TitleIndex = l:TitleIndex + 1
			endif
		endif

	endfor

endfunction
