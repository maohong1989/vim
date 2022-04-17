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

	let l:CommentType = ASL_DetectCommentStype()
	let l:TypeLeft    = l:CommentType.TypeLeft. ' '
	let l:TypeRight   = l:CommentType.TypeRight

	let l:TmpLeft     = substitute (l:TypeLeft, '[][*^.$~]', '\\&', 'g')
	let l:TypeLeft    = substitute (l:TypeLeft, '&', '\\&', 'g')

	if l:TypeRight == ''
		let b:Comment   = [ 'sm@^@'.l:TypeLeft.'@e' ]
		let b:UnComment = [ 'sm@^'. l:TmpLeft .'@@e' ]
	else
		let l:TmpRight  = substitute (l:TypeRight, '[][*^.$~]', '\\&', 'g')
		let l:TmpRight  = substitute (l:TmpRight, '^\s*', '\\s*', '')
		let l:TypeRight = substitute (l:TypeRight, '&', '\\&', 'g')
		" protect any comment that becomes nested
		" with non-ASCII chars, to avoid collisions
		let b:Comment    = ['sm@«¤@«¤¤@ge', 'sm@'.l:TmpLeft.'@«¤«@ge', 'sm@^@'.l:TypeLeft.'@e']
		let b:Comment   += ['sm@¤»@¤¤»@ge', 'sm@'.l:TmpRight.'@»¤»@ge', 'sm@$@'.l:TypeRight.'@e']
		let b:UnComment  = ['sm@^\s*'.l:TmpLeft.'@@e', 'sm@«¤«@'.l:TypeLeft.'@ge', 'sm@«¤¤@«¤@ge']
		let b:UnComment += ['sm@'.l:TmpRight.'\s*$@@e', 'sm@»¤»@'.l:TypeRight.'@ge', 'sm@¤¤»@¤»@ge']
	endif
		return {"Comment":b:Comment, "UnComment":b:UnComment}
endfunction

"++=" 函数：注释
function! ASL_Comment() range
	let l:ComStype = ASL_CommentStyle()
	for s in l:ComStype.Comment
 		execute ':sil '.a:firstline.','.a:lastline.s
	endfor
" 	echo l:ComStype
endfunction

"++="函数：去注释
function! ASL_UnComment() range
	let l:ComStype = ASL_CommentStyle()
  for s in l:ComStype.UnComment
    execute ':sil '.a:firstline.','.a:lastline.s
  endfor
endfunction
