#echo "                                          .l"
# echo "                     ,:                  ,:d"
# echo "                    ;:l   .,,,';;''..',,lok."
# echo "                   '0;l;;;. .. .  ..xcdO0d'."
# echo "                  .;KOkOdc'...   ,. dll,'..,;;"
# echo "                .,:, ';c.'.   .:';l  ;;.lKKO:."
# echo "          .;d0WWMX;okl', ,,     ..cc  .d..:c."
# echo "          .';o0XNWMOxOo.  ,,0Ko,     ':0;."
# echo "             ;lxkWkcxo,' .l;   ''     .l"
# echo "               ..o    ..               :O."
# echo "              ' ' .,, l;     .   :::'    :l,"
# echo "              l    :c:xl   . c;     ;;..'ck00"
# echo "  kuh->     ...  ; .llxK...;;..;.    : :koMMM;"
# echo "             c  ;: :d0dWKo;' .  .. '.,KXKWMMX,"
# echo "             o;.o ;cNMWWMW0O0KkkdddlkKOxddc"
# echo "             d';kcdkMMMWWNWNXWWWKOl,."
# echo "             o.d,xkWMWKNNNWMKc."
# echo "              oc:l0M0KWWWW0'"
# echo "               ;ccKXKNKWMx"
# echo "                 ..:o0KWX"
# echo "                   .;oKMo"
# echo "                      .d."

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

# alt + pfeiltasten fuer word jump
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

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
alias cow="mpv --no-config --no-audio --vo=tct --loop=inf --term-status-msg= $HOME/cow.mp4"

#######################################
#pip install path
export PATH=$PATH:$HOME/.local/bin

#######################################
#node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
