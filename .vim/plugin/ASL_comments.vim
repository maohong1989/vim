"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""                        版权所有，作者保留一切权利
"" 但保证本程序完整性（包括版权申明，作者信息）的前提下，欢迎任何人对此进行修改传播
"" 作者邮箱：apostle9891@foxmail.com，欢迎进行交流，请勿用于商业用途
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" 文 件 名: ASL_PRIVATE_FUN.vim
"" 作    者: apostle --- apostle9891@foxmail.com
"" 版    本: version 1.0
"" 日    期: 2013-11-17 11:06
"" 描    述: 此函数主要是为了对函数进行自动注释，自动注释的文件类型在ASL_COMMON.vim
"" 历史描述:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" [目录]
" --行数--- [目录]
" --20----- [函数：替换注释]
" --50----- [函数：注释]
" --58----- [函数：去注释]
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"++=" 函数：替换注释
function! ASL_CommentStyle()
	if exists('b:Comment') && exists('b:UnComment')
		return {'Comment':b:Comment, 'UnComment':b:UnComment}
	endif

	let a:CommentType = ASL_DetectCommentStype()
	let a:TypeLeft    = a:CommentType.TypeLeft. ' '
	let a:TypeRight   = a:CommentType.TypeRight

	let a:TmpLeft     = substitute (a:TypeLeft, '[][*^.$~]', '\\&', 'g')
	let a:TypeLeft    = substitute (a:TypeLeft, '&', '\\&', 'g')

	if a:TypeRight == ''
		let b:Comment   = [ 'sm@^@'.a:TypeLeft.'@e' ]
		let b:UnComment = [ 'sm@^'. a:TmpLeft .'@@e' ]
	else
		let a:TmpRight  = substitute (a:TypeRight, '[][*^.$~]', '\\&', 'g')
		let a:TmpRight  = substitute (a:TmpRight, '^\s*', '\\s*', '')
		let a:TypeRight = substitute (a:TypeRight, '&', '\\&', 'g')
		" protect any comment that becomes nested
		" with non-ASCII chars, to avoid collisions
		let b:Comment    = ['sm@«¤@«¤¤@ge', 'sm@'.a:TmpLeft.'@«¤«@ge', 'sm@^@'.a:TypeLeft.'@e']
		let b:Comment   += ['sm@¤»@¤¤»@ge', 'sm@'.a:TmpRight.'@»¤»@ge', 'sm@$@'.a:TypeRight.'@e']
		let b:UnComment  = ['sm@^\s*'.a:TmpLeft.'@@e', 'sm@«¤«@'.a:TypeLeft.'@ge', 'sm@«¤¤@«¤@ge']
		let b:UnComment += ['sm@'.a:TmpRight.'\s*$@@e', 'sm@»¤»@'.a:TypeRight.'@ge', 'sm@¤¤»@¤»@ge']
	endif
		return {"Comment":b:Comment, "UnComment":b:UnComment}
endfunction

"++=" 函数：注释
function! ASL_Comment() range
	let a:ComStype = ASL_CommentStyle()
	for s in a:ComStype.Comment
 		execute ':sil '.a:firstline.','.a:lastline.s
	endfor
" 	echo a:ComStype
endfunction

"++="函数：去注释
function! ASL_UnComment() range
	let a:ComStype = ASL_CommentStyle()
  for s in a:ComStype.UnComment
    execute ':sil '.a:firstline.','.a:lastline.s
  endfor
endfunction
