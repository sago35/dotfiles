autocmd BufNewFile *.pl set fileformat=unix
autocmd BufNewFile *.pl 0r $VIMLOCAL/template/perl-script.txt

autocmd BufNewFile *.t  set fileformat=unix
autocmd BufNewFile *.t  0r $VIMLOCAL/template/perl-test.txt

function! s:pm_template()
    let path = substitute(expand('%'), '.*lib/', '', 'g')
    let path = substitute(path, '[\\/]', '::', 'g')
    let path = substitute(path, '\.pm$', '', 'g')

    call append(0, 'package ' . path . ';')
    call append(1, 'use strict;')
    call append(2, 'use warnings;')
    call append(3, 'use utf8;')
    call append(4, '')
    call append(5, '')
    call append(6, '')
    call append(7, '1;')
    call cursor(6, 0)
    " echomsg path
endfunction
autocmd BufNewFile *.pm call s:pm_template()
