"if empty(globpath(&rtp, 'autoload/lsp.vim'))
"  finish
"endif

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> <f2> <plug>(lsp-rename)
  inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"

  nmap <buffer> ,i :LspHover<cr>
  nmap <buffer> <C-]> :LspDefinition<cr>
  nmap <buffer> <C-w><C-]> :sp<cr>:LspDefinition<cr>
  nmap <buffer> <C-Space>s :LspReferences<CR>:cclose<CR>
  nmap <buffer> <C-Space><C-Space>s :split<cr>:LspReferences<CR>:cclose<CR>
  nmap <buffer> ,i :LspHover<CR>
  nmap <buffer> ,f :LspDocumentFormat<cr>
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
