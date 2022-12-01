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
 	let a:Type           = copy(ASL_DetectCommentStype())

	call DetectTitleExist(a:Type)

	let a:TypeLeft       = a:Type.TypeLeft
	let a:TypeRight      = a:Type.TypeRight
" 	let a:TypeRight      = '//'
	let a:EdgRepeatWidth = g:ContentWidth / strlen(a:TypeLeft)

	let a:RepeatWidth    = strlen(a:TypeLeft) > 1 ? 1 : 2
	let a:TypeLeft       = repeat(a:TypeLeft, a:RepeatWidth)

	let a:TypeLeftWidth  = strlen(a:TypeLeft) + 1
	let a:ContentWidth   = strlen(g:TitleParam.TitleCopyRight.Width)
	let a:TypeRightWidth = g:ContentWidth - a:ContentWidth - a:TypeLeftWidth

	"add the edgings
  	call append(LineNum, repeat(a:Type.TypeLeft, a:EdgRepeatWidth))
	let LineNum = LineNum + 1

	"add the copyright
	for param in g:TitleParam.TitleCopyRight.Param
" 	for param in len(TitleParam.TitleCopyRight.Param)
		let a:Content        = param
		let a:newline        = printf("%-*s%-*s%*s",
								\a:TypeLeftWidth, a:TypeLeft,
								\a:ContentWidth, a:Content, a:TypeRightWidth, a:TypeRight)
" 		if g:TitleParam.TitleCopyRight.ModifyFlag[] == 1
			call append(LineNum, a:newline)
" 		else
" 			call setline(LineNum + 1, a:newline)
" 		endif
		let LineNum = LineNum + 1
	endfor

	"add the edgings
  	call append(LineNum, repeat(a:Type.TypeLeft, a:EdgRepeatWidth))
	let LineNum = LineNum + 1

	"add the TitleParam information
" 	let a:TypeLeftWidth  = strlen(a:TypeLeft) * a:RepeatWidth  + 1
" 	let a:ContentWidth   = strlen(g:TitleParam.TitleParamLeft.Width)
" 	let a:ContentWidth   = strlen(g:TitleParam.TitleCopyRight.Width)
" 	let a:TypeRightWidth = g:ContentWidth - a:ContentWidth - a:TypeLeftWidth
	for Param in sort(keys(g:TitleParam.TitleParamLeft.Param))
		"solve the problem the title type error,because when enter document, call expand('%'),the value is sure
		if Param == '1_FileName'
			let a:Content = get(g:TitleParam.TitleParamLeft.Param, Param, '?????')
						  \. expand('%')
	    else
			let a:Content = get(g:TitleParam.TitleParamLeft.Param, Param, '?????')
						  \. get(g:TitleParam.TitleParamRight.Param, Param, '?????')
	    endif
		let a:Content = printf("%-*s", a:ContentWidth, a:Content)
		let a:newline        = printf("%-*s%-*s%*s",
								\a:TypeLeftWidth, a:TypeLeft,
								\a:ContentWidth, a:Content, a:TypeRightWidth, a:TypeRight)
		call append(LineNum, a:newline)
		let LineNum = LineNum + 1
	endfor

	"add the edgings
  	call append(LineNum, repeat(a:Type.TypeLeft, a:EdgRepeatWidth))
	let LineNum = LineNum + 1
endfunction


function! Comment_set_Block(comment, ...)
let l:with = a:0 >= 1 ? a:1 : strlen(a:comment)+2
return repeat("//", 30)
endfunction

function! DetectTitleExist(Type)

	let a:TypeLeft = a:Type.TypeLeft
	let ASSING      = '^\%(' .a:TypeLeft. '\)\@!'

	let a:LastLine = 1
 	call cursor(1,0)
	let a:LastLine  = search(ASSING, 'nW') - 1
	let a:LineNum   = 1
	let a:StartLine = 1

	if a:LastLine < 0
		let	a:LastLine = 1
	endif

	let a:index      = 0
	let a:TitleIndex = 0
	for curline in getline(a:StartLine, a:LastLine)

		if a:index < len(g:TitleParam.TitleCopyRight.Param)
			if match(curline, g:TitleParam.TitleCopyRight.Param[a:index]) >= 0
				let	g:TitleParam.TitleCopyRight.ModifyFlag[a:index] = 0
				let a:index = a:index + 1
			endif
		endif

		if a:TitleIndex < len(g:TitleParam.TitleParamIndex)
			let a:IndexText = g:TitleParam.TitleParamIndex[a:TitleIndex]
			if match(curline, g:TitleParam.TitleParamLeft.Param[a:IndexText])>= 0
				let g:TitleParam.TitleParamFlag[a:IndexText] = 0
				let a:TitleIndex = a:TitleIndex + 1
			endif
		endif

	endfor

endfunction
