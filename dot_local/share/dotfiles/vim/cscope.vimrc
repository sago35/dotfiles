if has("cscope")
    set csprg=cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        "execute ":set path+=" . expand("%:p:h")
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif

au BufNewFile,BufRead *.c set cscopetag

au FileType c,cpp nnoremap <silent> <buffer> <C-Space>s :cs find s <C-R>=expand("<cword>")<CR><CR>
au FileType c,cpp nnoremap <silent> <buffer> <C-Space>g :cs find g <C-R>=expand("<cword>")<CR><CR>
au FileType c,cpp nnoremap <silent> <buffer> <C-Space>c :cs find c <C-R>=expand("<cword>")<CR><CR>
au FileType c,cpp nnoremap <silent> <buffer> <C-Space>t :cs find t <C-R>=expand("<cword>")<CR><CR>
au FileType c,cpp nnoremap <silent> <buffer> <C-Space>e :cs find e <C-R>=expand("<cword>")<CR><CR>
au FileType c,cpp nnoremap <silent> <buffer> <C-Space>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
au FileType c,cpp nnoremap <silent> <buffer> <C-Space>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
au FileType c,cpp nnoremap <silent> <buffer> <C-Space>d :cs find d <C-R>=expand("<cword>")<CR><CR>

au FileType c,cpp nnoremap <silent> <buffer> <C-Space><C-Space>s :scs find s <C-R>=expand("<cword>")<CR><CR>
au FileType c,cpp nnoremap <silent> <buffer> <C-Space><C-Space>g :scs find g <C-R>=expand("<cword>")<CR><CR>
au FileType c,cpp nnoremap <silent> <buffer> <C-Space><C-Space>c :scs find c <C-R>=expand("<cword>")<CR><CR>
au FileType c,cpp nnoremap <silent> <buffer> <C-Space><C-Space>t :scs find t <C-R>=expand("<cword>")<CR><CR>
au FileType c,cpp nnoremap <silent> <buffer> <C-Space><C-Space>e :scs find e <C-R>=expand("<cword>")<CR><CR>
au FileType c,cpp nnoremap <silent> <buffer> <C-Space><C-Space>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
au FileType c,cpp nnoremap <silent> <buffer> <C-Space><C-Space>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
au FileType c,cpp nnoremap <silent> <buffer> <C-Space><C-Space>d :scs find d <C-R>=expand("<cword>")<CR><CR>

function! ReloadCscopeDb ()
  cs kill -1
  if filereadable("cscope.out")
    silent !del cscope.out
  endif
  if filereadable("cscope.list")
    silent !cscope -b -i cscope.list
  elseif filereadable("files.txt")
    silent !cscope -b -i files.txt
  else
    silent !cscope -Rb
  endif
  cs add cscope.out
endfunction

nmap <F12> :call ReloadCscopeDb()<cr>

au FileType c,cpp nnoremap <silent> <buffer> gn :tnext<CR>zz
au FileType c,cpp nnoremap <silent> <buffer> gp :tprevious<CR>zz
au FileType c,cpp nnoremap <silent> <buffer> g] :pop<CR>

"set cscopequickfix=s-,c-,d-,i-,t-,e-
