
dotfiles für

- neovim
- tmux
- zsh


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

## install.sh
funktioniert nur fuer ubuntu, vielleicht
```bash
sudo apt-get update
sudo apt-get install git
cd $HOME
git clone https://github.com/schnuebel/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh
```


### Ref
https://www.youtube.com/watch?v=y6XCebnB9gs
