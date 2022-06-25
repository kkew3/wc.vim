if exists("load_wcvim")
    finish
endif
let load_wcvim=1

let s:current_dir = expand("<sfile>:p:h:h")
let s:stripwchar = s:current_dir . "/stripwchar.py"
if !filereadable(s:stripwchar)
    throw "stripwchar.py not found in plugin directory"
endif

function! CountCEWords() range
    try
        let l:ccount = split(execute(a:firstline . "," . a:lastline
                    \ . "s/[\u4e00-\u9fa5\u3040-\u30FF]//gn"))[0]
    catch
        let l:ccount = "0"
    endtry
    let l:stdin = join(getline(a:firstline, a:lastline), "\n")
    if &filetype != "tex"
        let l:ecount = len(split(system("python3 " . shellescape(s:stripwchar),
                    \ l:stdin)))
    else
        let l:ecount = len(split(system("detex -n \| "
                    \ . "python3 " . shellescape(s:stripwchar),
                    \ l:stdin)))
    endif
    echo "C " . l:ccount . " E " . l:ecount
endfunction
