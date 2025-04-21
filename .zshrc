# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

########################################
#zsh
#history

autoload -U compinit && compinit

setopt SHARE_HISTORY
HISTFILE=$HOME/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
#commands mit nem space am anfang werden nicht in history gespeichert
#nicht wundern bis zum naechsten command ist das dann noch in der hist
setopt hist_ignore_space 
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# das hier ist geht wahrscheinlich nur in wsl
bindkey "${terminfo[kcuu1]}" history-search-backward
bindkey "${terminfo[kcud1]}" history-search-forward
# fuer andere setups funktioniert das hier bestimmt
# bindkey '^[[A' history-search-backward
# bindkey '^[[B' history-search-forward

########################################
### zinit packet manager
#init zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Self update
# zinit self-update

# Plugin update
# zinit update

# Load powerlevel10k theme
zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

# autosuggestion
zinit light zsh-users/zsh-autosuggestions

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#######################################
#neovim
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

#######################################
#tmux
alias thelp='cat $HOME/.tmux.conf | grep bind'
alias taa='tmux a'
alias tll='tmux list-sessions'
alias tw='$HOME/dotfiles/create-tmux-workspace.sh'

#######################################
#golang
export PATH=$PATH:/usr/local/go/bin

#######################################
#snap
export PATH=$PATH:/snap/bin

#######################################
#git
alias ga="git add"
alias gs="git status"
alias gd="git diff"
alias gcm="git commit -m"
alias gp="git push"

#######################################
#misc
alias ll="ls --color -la"

#######################################
#pip install path
export PATH=$PATH:$HOME/.local/bin
