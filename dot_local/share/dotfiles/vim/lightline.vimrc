let g:lightline = {
            \   'active': {
            \     'left': [
            \       [ 'mode', 'paste' ],
            \       [ 'gitbranch', 'readonly', 'myfilename', 'modified' ],
            \     ],
            \     'right': [
            \       [ 'lineinfo' ],
            \       [ 'percent' ],
            \       [ 'fileformat', 'fileencoding', 'filetype' ],
            \     ],
            \   },
            \   'component_function' : {
            \     'myfilename': 'MyFilename',
            \     'gitbranch': 'fugitive#head',
            \   },
            \ }
let g:lightline.inactive = g:lightline.active
"let g:lightline.colorscheme = 'wombat'

function! MyFilename()
    let opt = &shellslash
    set shellslash
    let p = expand("%:.")

    if p[0] == '/'
        let p = expand("%:p")
    endif

    let &shellslash = opt
    return p
endfunction
