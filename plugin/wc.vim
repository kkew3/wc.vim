if exists("load_wcvim")
    finish
endif
let load_wcvim=1

let s:current_dir = expand("<sfile>:p:h:h")
let s:stripwchar = s:current_dir . "/stripwchar.py"
if !filereadable(s:stripwchar)
    throw "stripwchar.py not found in plugin directory"
endif

function! s:CountCEWords() range
    try
        let l:ccount = split(execute(a:firstline . "," . a:lastline
                    \ . "s/[\u4e00-\u9fa5\u3040-\u30FF]//n"))[0]
        let l:cwcount = split(execute(a:firstline . "," . a:lastline
                    \ . "s/[\u4e00-\u9fa5\u3002\uFF1F\uFF01\u3010\u3011\uFF0C\u3001\uFF1B\uFF1A\u300C\u300D\u300E\u300F\u2019\u201C\u201D\u2018\uFF08\uFF09\u3014\u3015\u2026\u2013\uFF0E\u2014\u300A\u300B\u3008\u3009]//n"))[0]
    catch
        let l:ccount = "0"
        let l:cwcount = "0"
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
    echo "C " . l:ccount . " CW " . l:cwcount . " E " . l:ecount
endfunction

command! -range=% -bar Wc
            \ let winview=winsaveview() |
            \ <line1>,<line2>call s:CountCEWords() |
            \ call winrestview(winview)
