"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
if (has('win32'))
  set runtimepath+=$VIM/dein/repos/github.com/Shougo/dein.vim
  call dein#begin('$VIM/dein')
else
  set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
  call dein#begin('~/.vim/dein')
endif

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('tpope/vim-fugitive')
call dein#add('tomasr/molokai')
call dein#add('itchyny/lightline.vim')
call dein#add('hotchpotch/perldoc-vim')
call dein#add('fatih/vim-go')
call dein#add('sago35/mark.vim')
call dein#add('scrooloose/syntastic')

" You can specify revision/branch/tag.
call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------
