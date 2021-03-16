# dotfiles

My dotfiles.

# usage

volt での設定例  
管理者権限じゃないと vim-go のインストールがこける  

```
cd path/to/install_dir
copy %GOPATH%\src\github.com\sago35\dotfiles\vim\init\* .

go get -u -v github.com/koron/netupvim
echo source = "vim.org" > netupvim.ini

go get -u -v github.com/mattn/sudo
go get -u -v github.com/vim-volt/volt

volt get tpope/vim-fugitive
volt get itchyny/lightline.vim
volt get hotchpotch/perldoc-vim
volt get ctrlpvim/ctrlp.vim
volt get sago35/mark.vim
volt get sago35/molokai
volt get sago35/yankrev.vim
volt get cocopon/vaffle.vim
volt get vim-jp/vimdoc-ja
volt get sago35/tinygo.vim
```

go get -v github.com/sago35/tinygo-autocmpl

環境変数 PATH に以下を追加する。

```
setx PATH=%GOPATH%\src\github.com\sago35\dotfiles\bin\windows;%PATH%
```
