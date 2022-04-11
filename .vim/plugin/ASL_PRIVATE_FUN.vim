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
	let a:CommentType = ASL_DetectCommentStype()
	let a:TypeLeft    = a:CommentType.TypeLeft
	let a:TypeRight   = a:CommentType.TypeRight
	let a:TypeWidth   = strlen(a:TypeLeft) + strlen(a:TypeRight)
	let a:my_author   = g:MY_AUTHOR
" 	let a:my_logo     = repeat(a:intype, 2).'['.a:my_author.']'.repeat(a:intype, 2).
" 						\'['.strftime('%Y-%m-%d %H:%M').']'.repeat(a:intype, 2)
 	let a:my_logo     = a:my_author.repeat(a:intype, 2).
 						\'['.strftime('%Y-%m-%d').']'.repeat(a:intype, 2)
	let a:tab_len     = g:TAB_LEN

	let a:max_width  = g:MAX_CONTENT_WIDTH
	let a:min_width  = strlen(a:my_logo)
	let a:line_width = 0
	let a:n          = a:firstline

	while a:n <= a:lastline
		let a:tmp_content = getline(a:n)
		let a:tmp_content = substitute(a:tmp_content, '\t', '    ', 'g')
		let a:tmp_width   = strlen(a:tmp_content)
		let a:line_width  = a:tmp_width > a:line_width ? a:tmp_width : a:line_width
		let a:n           = a:n + 1
	endwhile

	if a:line_width > a:max_width
		let a:line_width = a:max_width
	endif
	if a:line_width < a:min_width
		let a:line_width = a:min_width
	endif

	if a:TypeRight == ''
		let a:head_content = a:TypeLeft.repeat(a:intype,2).'=='.a:my_logo.
					\repeat(a:intype, (a:line_width - a:min_width - a:TypeWidth - 4))
		let a:tail_content = a:TypeLeft.repeat(a:intype,2).'__'.a:my_logo.
					\repeat(a:intype, (a:line_width - a:min_width - a:TypeWidth - 4))
" 		let a:tail_content = a:TypeLeft.repeat(a:intype, a:line_width - a:TypeWidth)
	else
		let a:head_content = a:TypeLeft.repeat(a:intype,2).'=='.a:my_logo.
							\repeat(a:intype, (a:line_width - a:min_width - a:TypeWidth - 4)).
							\a:TypeRight
		let a:head_content = a:TypeLeft.repeat(a:intype,2).'__'.a:my_logo.
							\repeat(a:intype, (a:line_width - a:min_width - a:TypeWidth - 4)).
							\a:TypeRight
" 		let a:tail_content = a:TypeLeft.repeat(a:intype, a:line_width - a:TypeWidth).
" 							\a:TypeRight
	endif

	call append(a:firstline - 1, a:head_content)
	call append(a:lastline  + 1, a:tail_content)
endfunction

"=@_@=" 函数：清除当前文件里的logo
function! ASL_CleanMark()range
	let a:order = 'g/^.\{-}\([-+]\{2}\([_=]\{2}\)\@=\).*$/d'
	execute ':sil '.a:firstline.','.a:lastline.a:order
endfunction
" map ,+ :call ASL_AddModifyMark('+')<CR>     "注释
" map ,- :call ASL_AddModifyMark('-')<CR>
" map ,n /++\([_=]\)\@=<CR>
" map ,_ :call ASL_CleanMark()<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:TabMark = '=@_\+@='
"=@_@=" 函数：增加文件目录
function! ASL_PrintTable()
	let a:CommentType = ASL_DetectCommentStype()
	let a:TypeLeft    = a:CommentType.TypeLeft
	let a:TypeRight   = a:CommentType.TypeRight
	let a:CurLineNum  = line('.')
	let a:MyMark      = a:TypeLeft.g:TabMark.a:TypeLeft
	let a:MatchLine   = search(a:MyMark, 'nW')
	let a:LineNum     = -1

	"if no find, return
	if a:MatchLine == 0
		return 0
	endif

	"print the table
	let a:LineNum     = a:LineNum + 1
	let a:TabName     = a:TypeLeft.' [目录]'
	call append(a:CurLineNum+a:LineNum-1, a:TabName)

	let a:LineNum     = a:LineNum + 1
	let a:TabName     = a:TypeLeft.' --行数--- [目录]'
	call append(a:CurLineNum+a:LineNum-1, a:TabName)

	"detect the sum of line num
	let a:SumNum = 0
	let a:SecTab  = 0
	let a:ThirTab = 0
	while 1
		let a:MatchLine   = search(a:MyMark, 'W')

		if a:MatchLine == 0
			break
		endif
		let a:SumNum = a:SumNum + 1
	endwhile
	call cursor(a:CurLineNum, 0)

	"print the index
	let a:MainTab         = 0
	while 1
		let a:LineNum     = a:LineNum + 1
		let a:MatchLine   = search(a:MyMark, 'W')

		if a:MatchLine == 0
			break
		endif

		let a:TabName      = getline(a:MatchLine)
		let a:MatchLine    = a:MatchLine + a:SumNum - a:LineNum+2
" 		let a:TabName      = substitute(a:TabName, '^'.a:MyMark.'\s*', '', '')
" 		let ASSING         = '^\^('.a:MyMark.'\)\s*\(.*\)$'
"		let ASSING = '^'.a:TypeLeft.'\)'.'\{-}\('.a:MyMark.'\)\s*\(.\{-}\)\('.a:TypeLeft.'\)*$'
		let ASSING = '^'.'\('.a:TypeLeft.'\)'.'\{-}\('.a:MyMark.'\)\s*\(.\{-}\)\('.a:TypeLeft.'\)*$'
"		let ASSING = substitute(ASSING, '/', '\\&', 'g')
"注释：a:Typeleft is  \" then ASSIN = '^"\+\("=@_\+@="\)\s*\(.\{-}\)"*$' 
		let a:MatchListTmp = matchlist(a:TabName, ASSING)
" 		echo a:MatchListTmp
		let a:MatchHead    = a:MatchListTmp[2]
		let a:MatchContent = a:MatchListTmp[3]
		let a:TableLevel   = 0
		let a:TmpLineNum   = 0

		"add the 1 1.1等次级坐标
		while 1
			let a:Tmp = matchend(a:MatchHead, '_', a:TmpLineNum)
			if a:Tmp < 0
				break
			else
				let a:TmpLineNum = a:Tmp
			endif
			let a:TableLevel = a:TableLevel + 1
		endwhile

		"三级目录答应
		if a:TableLevel == 1
			let a:MainTab = a:MainTab + 1
			let a:SecTab  = 0
			let a:ThirTab = 0
		elseif a:TableLevel == 2
			let a:SecTab  = a:SecTab + 1
			let a:ThirTab = 0
		else
			let a:ThirTab = a:ThirTab + 1
		endif

		if a:MainTab == 0
			continue
		else
			let a:TabNumName = ' '.a:MainTab
			if a:SecTab != 0
				let a:TabNumName ='  '. a:TabNumName.'.'.a:SecTab
				if a:ThirTab != 0
					let a:TabNumName = '    '.a:TabNumName.'.'.a:ThirTab
				endif
			endif
		endif
	let a:AddLine   = a:TypeLeft.' --'.a:MatchLine.repeat('-',
				\(7-strlen(a:MatchLine))).a:TabNumName.' ['.a:MatchContent.']'
	call append(a:CurLineNum+a:LineNum-1, a:AddLine)
" 		let a:AddLine   = a:TypeLeft.' --'.a:MatchLine.repeat('-',
" 							\(7-strlen(a:MatchLine))).' ['.a:MatchContent.']'
" 		call append(a:CurLineNum+a:LineNum-1, a:TabName)
	endwhile
	call cursor(a:CurLineNum, 0)
endfunction
