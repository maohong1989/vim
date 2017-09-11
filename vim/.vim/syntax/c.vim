"syn match cFuntions display "[a-zA-Z_]\{-1,}\s\{-0,}(\{1}"ms=s,me=e-1
"hi def link cFuntions Title
"highlight Functions
syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
hi cFunctions gui=NONE cterm=bold  ctermfg=blue


