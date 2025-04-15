
dotfiles für

- neovim
- tmux


# Install
benutzt stow

der /dotfiles ordner muss im homeverzeichnis liegen

stow macht dann die entsprechenden links

``` bash
sudo apt install stow git
```

``` bash
cd $HOME
git clone git@github.com:schnuebel/dotfiles.git 
cd dotfiles
stow .
```


### Ref
https://www.youtube.com/watch?v=y6XCebnB9gs
