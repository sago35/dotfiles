# dotfiles

My dotfiles.

# usage

volt での設定例  
管理者権限じゃないと vim-go のインストールがこける  

```
go get github.com/vim-volt/volt

volt get tpope/vim-fugitive
volt get itchyny/lightline.vim
volt get hotchpotch/perldoc-vim
volt get fatih/vim-go
volt get ctrlpvim/ctrlp.vim
volt get sago35/mark.vim
volt get sago35/molokai
volt get sago35/yankrev.vim
volt get cocopon/vaffle.vim
volt get vim-jp/vimdoc-ja
```

環境変数 PATH に以下を追加する。

```
setx PATH=%GOPATH%\src\github.com\sago35\dotfiles\bin\windows;%PATH%
```
