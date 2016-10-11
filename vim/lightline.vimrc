let g:lightline = {
            \   'active': {
            \     'left': [
            \       [ 'mode', 'paste' ],
            \       [ 'readonly', 'myfilename', 'modified' ],
            \     ],
            \     'right': [
            \       [ 'lineinfo' ],
            \       [ 'percent' ],
            \       [ 'fileformat', 'fileencoding', 'filetype' ],
            \     ],
            \   },
            \   'component_function' : {
            \     'myfilename': 'MyFilename',
            \   },
            \ }

function! MyFilename()
    return expand("%:.")
endfunction
