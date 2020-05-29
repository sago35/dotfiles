"" vim-go
"au FileType go nnoremap <silent> <buffer> <C-Space>s :GoReferrers<CR>:cclose<CR>
"au FileType go nnoremap <silent> <buffer> <C-Space>c :GoCallers<CR>:cclose<CR>
"
"au FileType go nnoremap <silent> <buffer> <C-Space><C-Space>s :split<cr>:GoReferrers<CR>:cclose<CR>
"au FileType go nnoremap <silent> <buffer> <C-Space><C-Space>c :split<cr>:GoCallers<CR>:cclose<CR>
"
"au FileType go nnoremap <silent> <buffer> [d :GoDescribe<CR><C-w>k
"au FileType go nnoremap <silent> <buffer> ,i :GoInfo<CR>
"
""let g:go_def_mapping_enabled = 0
"
"let g:go_list_height = 10
"let g:go_list_type = "quickfix"
"let g:go_fmt_command="goimports"
"let g:go_def_mode = 'gopls'
"let g:go_info_mode='gopls'
"
"let g:go_metalinter_enabled=['vet', 'vetshadow', 'golint', 'ineffassign', 'goconst', 'goimports']
"let g:go_metalinter_autosave_enabled=['vet', 'vetshadow', 'golint', 'ineffassign', 'goconst', 'goimports']
"let g:go_metalinter_autosave=0
"
"let g:go_auto_type_info=1
"let g:go_updatetime=300
"let g:go_auto_sameids = 0
"
"let g:go_jump_to_error = 0
