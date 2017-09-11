""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""                        版权所有，作者保留一切权利                                  
"" 在保证本程序完整性（包括版权申明，作者信息）的前提下，欢迎任何人对此进行修改传播。 
"" 作者邮箱：apostle9891@foxmail.com，欢迎进行交流，请勿用于商业用途                  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" 文 件 名: ASL_Plugin_For_C.vim                                                  
"" 作    者: apostle --- apostle9891@foxmail.com                                    
"" 版    本: version 1.0                                                            
"" 日    期: 2017-04-08 14:13                                                       
"" 描    述: 打开一个新的文件则加上注释                                                                    
"" 历史描述:                                                                      
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile *.h,*.c,*.hh,*.cpp exec ":call ASL_SetTitleForC()"

function! ASL_DectetCurHead()
	let a:NewLine = "__".toupper(expand("%:r"))."_".toupper(expand("%:e"))."__"
	return a:NewLine
endfunction

function! ASL_SetTitleForC()
	let HeadType = ["h", "hh"]
	let CType = ["c", "cpp"]
	let HeadLine = 12

	if expand("%:e") == 'h'
		"add title
		call Add_title()

		"add head
		call append(HeadLine, "#ifndef ".ASL_DectetCurHead())
		let HeadLine = HeadLine + 1
		call append(HeadLine, "#define ".ASL_DectetCurHead())
		let HeadLine = HeadLine + 1

		"add must include head
		call append(HeadLine,     "#include <stdio.h>")
		let HeadLine = HeadLine + 1
		call append(HeadLine,     "#include <stdlib.h>")
		let HeadLine = HeadLine + 1


		"add c_heand
		call append(HeadLine, "#ifdef __cplusplus")
		let HeadLine = HeadLine + 1
		call append(HeadLine, "#if __cplusplus")
		let HeadLine = HeadLine + 1
		call append(HeadLine, "extern \"C\"\{")
		let HeadLine = HeadLine + 1
		call append(HeadLine, "#endif")
		let HeadLine = HeadLine + 1
		call append(HeadLine, "#endif /\* end of cplusplus\*/")
		let HeadLine = HeadLine + 1

		call append(HeadLine, "")
		let HeadLine = HeadLine + 1

		"保存当前的位置
		let space_local = HeadLine

		call append(HeadLine, "")
		let HeadLine = HeadLine + 1
		call append(HeadLine, "")
		let HeadLine = HeadLine + 1

		"add c_heand
		call append(HeadLine,  "#ifdef __cplusplus")
		let HeadLine = HeadLine + 1
		call append(HeadLine,  "#if __cplusplus")
		let HeadLine = HeadLine + 1
		call append(HeadLine,  "\}")
		let HeadLine = HeadLine + 1
		call append(HeadLine, "#endif")
		let HeadLine = HeadLine + 1
		call append(HeadLine, "#endif /\* end of cplusplus\*/")
		let HeadLine = HeadLine + 1
		"add end
		call append(HeadLine, "#endif /\* end of".ASL_DectetCurHead()."\*/")
		let HeadLine = HeadLine + 1

		call cursor(space_local, 1)

	elseif expand("%:e") == 'c'
		"add title
		call Add_title()

		call append(HeadLine,     "#include <stdio.h>")
		let HeadLine = HeadLine + 1
		call append(HeadLine,     "#include <stdlib.h>")
		let HeadLine = HeadLine + 1
		call append(HeadLine,     "#include <string.h>")
		let HeadLine = HeadLine + 1
		call append(HeadLine,     "#include <sys/types.h>")
		let HeadLine = HeadLine + 1
		call append(HeadLine,     "#include <sys/unistd.h>")
		let HeadLine = HeadLine + 1
		call append(HeadLine, "")
		let HeadLine = HeadLine + 1

		"add c_heand
		call append(HeadLine,     "#ifdef __cplusplus")
		let HeadLine = HeadLine + 1
		call append(HeadLine, "#if __cplusplus")
		let HeadLine = HeadLine + 1
		call append(HeadLine, "extern \"C\"\{")
		let HeadLine = HeadLine + 1
		call append(HeadLine, "#endif")
		let HeadLine = HeadLine + 1
		call append(HeadLine, "#endif /\* end of cplusplus\*/")
		let HeadLine = HeadLine + 1


		call append(HeadLine, "")
		let HeadLine = HeadLine + 1

		"保存当前的位置
		let space_local = HeadLine

		call append(HeadLine, "")
		let HeadLine = HeadLine + 1
		call append(HeadLine, "")
		let HeadLine = HeadLine + 1

		"add c_heand
		call append(HeadLine,  "#ifdef __cplusplus")
		let HeadLine = HeadLine + 1
		call append(HeadLine,  "#if __cplusplus")
		let HeadLine = HeadLine + 1
		call append(HeadLine,  "\}")
		let HeadLine = HeadLine + 1
		call append(HeadLine, "#endif")
		let HeadLine = HeadLine + 1
		call append(HeadLine, "#endif /\* end of cplusplus\*/")
		let HeadLine = HeadLine + 1


		"move to 24 line
		call cursor(space_local, 1)

	elseif expand("%:e") == 'cpp'

		"add title
		call Add_title()

		call append(HeadLine,     "#include <iostream>")
		let HeadLine = HeadLine + 1

		call append(HeadLine, "")
		let HeadLine = HeadLine + 1

		"保存当前的位置
		let space_local = HeadLine

		"move to 24 line
		call cursor(space_local, 1)

	elseif expand("%:e") == 'hh'

		"add title
		call Add_title()

		"add head
		call append(HeadLine, "#ifndef ".ASL_DectetCurHead())
		let HeadLine = HeadLine + 1
		call append(HeadLine, "#define ".ASL_DectetCurHead())
		let HeadLine = HeadLine + 1

		call append(HeadLine, "")
		let HeadLine = HeadLine + 1
		"保存当前的位置
		let space_local = HeadLine

		call append(HeadLine, "")
		let HeadLine = HeadLine + 1

		call append(HeadLine, "#endif /\* end of".ASL_DectetCurHead()."\*/")
		let HeadLine = HeadLine + 1
		"move to 24 line
		call cursor(space_local, 1)

	endif

endfunction

