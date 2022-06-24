if exists("load_wcvim")
    finish
endif
let load_wcvim=1

function! CountCEWords()
    try
        let l:ccount = split(execute(':%s/[\u4e00-\u9fa5\u3040-\u30FF]//gn'))[0]
    catch
        let l:ccount = "0"
    endtry
    let l:stripwchar = expand("<sfile>:p:h:h") . "/stripwchar.py"
    if !filereadable(l:stripwchar)
        throw "stripwchar.py not found in plugin directory"
    endif
    let l:ecount = system(l:stripwchar . " " . bufname("%") . " \| wc -w \| "
                \ . "awk '{ print $1 }' \| tr -d '\n'")
    echon "C " . l:ccount . " E " . l:ecount
endfunction

command! -nargs=0 Wc call CountCEWords()
