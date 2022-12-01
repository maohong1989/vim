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
" --20----- 1 [功能：自动添加自己的logo,时间]
" --21----- 2 [函数:自动添加自己的logo]
" --75----- 3 [函数：清除当前文件里的logo]
" --86----- 4 [函数：增加文件目录]
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=@_@=" 功能：自动添加自己的logo,时间
"=@_@=" 函数:自动添加自己的logo
function! ASL_AddModifyMark(intype) range
	let l:CommentType = ASL_DetectCommentStype()
	let l:TypeLeft    = l:CommentType.TypeLeft
	let l:TypeRight   = l:CommentType.TypeRight
	let l:TypeWidth   = strlen(l:TypeLeft) + strlen(l:TypeRight)
	let l:my_author   = g:MY_AUTHOR
" 	let l:my_logo     = repeat(a:intype, 2).'['.l:my_author.']'.repeat(a:intype, 2).
" 						\'['.strftime('%Y-%m-%d %H:%M').']'.repeat(a:intype, 2)
 	let l:my_logo     = l:my_author.repeat(a:intype, 2).
 						\'['.strftime('%Y-%m-%d').']'.repeat(a:intype, 2)
	let l:tab_len     = g:TAB_LEN

	let l:max_width  = g:MAX_CONTENT_WIDTH
	let l:min_width  = strlen(l:my_logo)
	let l:line_width = 0
	let l:n          = l:firstline

	while l:n <= l:lastline
		let l:tmp_content = getline(l:n)
		let l:tmp_content = substitute(l:tmp_content, '\t', '    ', 'g')
		let l:tmp_width   = strlen(l:tmp_content)
		let l:line_width  = l:tmp_width > l:line_width ? l:tmp_width : l:line_width
		let l:n           = l:n + 1
	endwhile

	if l:line_width > l:max_width
		let l:line_width = l:max_width
	endif
	if l:line_width < l:min_width
		let l:line_width = l:min_width
	endif

	if l:TypeRight == ''
		let l:head_content = l:TypeLeft.repeat(l:intype,2).'=='.l:my_logo.
					\repeat(l:intype, (l:line_width - l:min_width - l:TypeWidth - 4))
		let l:tail_content = l:TypeLeft.repeat(l:intype,2).'__'.l:my_logo.
					\repeat(a:intype, (l:line_width - l:min_width - l:TypeWidth - 4))
" 		let l:tail_content = l:TypeLeft.repeat(a:intype, l:line_width - l:TypeWidth)
	else
		let l:head_content = l:TypeLeft.repeat(a:intype,2).'=='.l:my_logo.
							\repeat(a:intype, (l:line_width - l:min_width - l:TypeWidth - 4)).
							\l:TypeRight
		let l:head_content = l:TypeLeft.repeat(a:intype,2).'__'.l:my_logo.
							\repeat(a:intype, (l:line_width - l:min_width - l:TypeWidth - 4)).
							\l:TypeRight
" 		let l:tail_content = l:TypeLeft.repeat(a:intype, l:line_width - l:TypeWidth).
" 							\l:TypeRight
	endif

	call append(l:firstline - 1, l:head_content)
	call append(l:lastline  + 1, l:tail_content)
endfunction

"=@_@=" 函数：清除当前文件里的logo
function! ASL_CleanMark()range
	let l:order = 'g/^.\{-}\([-+]\{2}\([_=]\{2}\)\@=\).*$/d'
	execute ':sil '.l:firstline.','.l:lastline.l:order
endfunction
" map ,+ :call ASL_AddModifyMark('+')<CR>     "注释
" map ,- :call ASL_AddModifyMark('-')<CR>
" map ,n /++\([_=]\)\@=<CR>
" map ,_ :call ASL_CleanMark()<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:TabMark = '=@_\+@='
"=@_@=" 函数：增加文件目录
function! ASL_PrintTable()
	let l:CommentType = ASL_DetectCommentStype()
	let l:TypeLeft    = l:CommentType.TypeLeft
	let l:TypeRight   = l:CommentType.TypeRight
	let l:CurLineNum  = line('.')
	let l:MyMark      = l:TypeLeft.g:TabMark.l:TypeLeft
	let l:MatchLine   = search(l:MyMark, 'nW')
	let l:LineNum     = -1

	"if no find, return
	if l:MatchLine == 0
		return 0
	endif

	"print the table
	let l:LineNum     = l:LineNum + 1
	let l:TabName     = l:TypeLeft.' [目录]'
	call append(l:CurLineNum+l:LineNum-1, l:TabName)

	let l:LineNum     = l:LineNum + 1
	let l:TabName     = l:TypeLeft.' --行数--- [目录]'
	call append(l:CurLineNum+l:LineNum-1, l:TabName)

	"detect the sum of line num
	let l:SumNum = 0
	let l:SecTab  = 0
	let l:ThirTab = 0
	while 1
		let l:MatchLine   = search(l:MyMark, 'W')

		if l:MatchLine == 0
			break
		endif
		let l:SumNum = l:SumNum + 1
	endwhile
	call cursor(l:CurLineNum, 0)

	"print the index
	let l:MainTab         = 0
	while 1
		let l:LineNum     = l:LineNum + 1
		let l:MatchLine   = search(l:MyMark, 'W')

		if l:MatchLine == 0
			break
		endif

		let l:TabName      = getline(l:MatchLine)
		let l:MatchLine    = l:MatchLine + l:SumNum - l:LineNum+2
" 		let l:TabName      = substitute(l:TabName, '^'.l:MyMark.'\s*', '', '')
" 		let ASSING         = '^\^('.l:MyMark.'\)\s*\(.*\)$'
"		let ASSING = '^'.l:TypeLeft.'\)'.'\{-}\('.l:MyMark.'\)\s*\(.\{-}\)\('.l:TypeLeft.'\)*$'
		let ASSING = '^'.'\('.l:TypeLeft.'\)'.'\{-}\('.l:MyMark.'\)\s*\(.\{-}\)\('.l:TypeLeft.'\)*$'
"		let ASSING = substitute(ASSING, '/', '\\&', 'g')
"注释：l:Typeleft is  \" then ASSIN = '^"\+\("=@_\+@="\)\s*\(.\{-}\)"*$' 
		let l:MatchListTmp = matchlist(l:TabName, ASSING)
" 		echo l:MatchListTmp
		let l:MatchHead    = l:MatchListTmp[2]
		let l:MatchContent = l:MatchListTmp[3]
		let l:TableLevel   = 0
		let l:TmpLineNum   = 0

		"add the 1 1.1等次级坐标
		while 1
			let l:Tmp = matchend(l:MatchHead, '_', l:TmpLineNum)
			if l:Tmp < 0
				break
			else
				let l:TmpLineNum = l:Tmp
			endif
			let l:TableLevel = l:TableLevel + 1
		endwhile

		"三级目录答应
		if l:TableLevel == 1
			let l:MainTab = l:MainTab + 1
			let l:SecTab  = 0
			let l:ThirTab = 0
		elseif l:TableLevel == 2
			let l:SecTab  = l:SecTab + 1
			let l:ThirTab = 0
		else
			let l:ThirTab = l:ThirTab + 1
		endif

		if l:MainTab == 0
			continue
		else
			let l:TabNumName = ' '.l:MainTab
			if l:SecTab != 0
				let l:TabNumName ='  '. l:TabNumName.'.'.l:SecTab
				if l:ThirTab != 0
					let l:TabNumName = '    '.l:TabNumName.'.'.l:ThirTab
				endif
			endif
		endif
	let l:AddLine   = l:TypeLeft.' --'.l:MatchLine.repeat('-',
				\(7-strlen(l:MatchLine))).l:TabNumName.' ['.l:MatchContent.']'
	call append(l:CurLineNum+l:LineNum-1, l:AddLine)
" 		let l:AddLine   = l:TypeLeft.' --'.l:MatchLine.repeat('-',
" 							\(7-strlen(l:MatchLine))).' ['.l:MatchContent.']'
" 		call append(l:CurLineNum+l:LineNum-1, l:TabName)
	endwhile
	call cursor(l:CurLineNum, 0)
endfunction
