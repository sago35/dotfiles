au FileType go nnoremap <silent> <buffer> <C-Space>s :GoReferrers<CR>:cclose<CR>
au FileType go nnoremap <silent> <buffer> <C-Space>c :GoCallers<CR>:cclose<CR>

au FileType go nnoremap <silent> <buffer> <C-Space><C-Space>s :split<cr>:GoReferrers<CR>:cclose<CR>
au FileType go nnoremap <silent> <buffer> <C-Space><C-Space>c :split<cr>:GoCallers<CR>:cclose<CR>

au FileType go nnoremap <silent> <buffer> [d :GoDescribe<CR><C-w>k
au FileType go nnoremap <silent> <buffer> ,i :GoInfo<CR>

let g:go_list_height = 10
let g:go_list_type = "quickfix"
let g:go_fmt_command="goimports"

let g:go_metalinter_enabled=['vet', 'vetshadow', 'golint', 'ineffassign', 'goconst', 'goimports']
let g:go_metalinter_autosave_enabled=['vet', 'vetshadow', 'golint', 'ineffassign', 'goconst', 'goimports']
let g:go_metalinter_autosave=1
