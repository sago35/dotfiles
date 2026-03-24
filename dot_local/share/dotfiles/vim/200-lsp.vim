"if empty(globpath(&rtp, 'autoload/lsp.vim'))
"  finish
"endif

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  nnoremap <buffer> gd <plug>(lsp-definition)
  nnoremap <buffer> <f2> <plug>(lsp-rename)
  inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"

  nnoremap <buffer> ,i <plug>(lsp-hover)
  nnoremap <buffer> <C-]> <plug>(lsp-definition)
  nnoremap <buffer> <C-w><C-]> :sp<cr><plug>(lsp-definition)
  nnoremap <buffer> <C-Space>s <plug>(lsp-references):cclose<CR>
  nnoremap <buffer> <C-Space><C-Space>s :split<cr><plug>(lsp-references):cclose<CR>
  nnoremap <buffer> ,f <plug>(lsp-document-format)
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')

"let g:lsp_diagnostics_enabled = 1
"let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_auto_popup = 0
let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_popup_delay = 200
let g:lsp_text_edit_enabled = 1

"let g:lsp_use_event_queue = 1
"let g:lsp_highlights_enabled = 0
"let g:lsp_highlight_references_enabled = 0
"let g:lsp_diagnostics_enabled=1
"let g:lsp_diagnostics_echo_cursor=1

let g:lsp_semantic_enabled = 1
let g:lsp_diagnostics_virtual_text_enabled = 0
