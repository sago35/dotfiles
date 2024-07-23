# dotfiles

## install

```
# for windows
$ scoop install chezmoi 7zip autohotkey ghq vim
```

```
$ chezmoi init sago35

$ chezmoi apply
```

```
$ ssh-keygen -t ed25519
$ cat ~/.ssh/id_ed25519.pub | clip

$ ghq get sago35/dotfiles
$ cd ~/dev/src/github.com/sago35/dotfiles && git checkout windows && cp -r dev ~

$ git clone --recurse-submodules https://github.com/sago35/vim-plugins ~/.local/share/vim-plugins
```
