# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '

source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

export FZF_CTRL_T_COMMAND='ag --hidden --ignore .git --ignore .cache/yay -l -g ""'
export FZF_ALT_C_COMMAND='find -type d 2>/dev/null'
export FZF_DEFAULT_OPTS='--height 80% --layout=reverse'

alias acee='acestream-engine --client-console --log-stdout-level debug --log-debug 355'
alias acel='acestream-launcher -v -p "mpv" -e "acestream-engine --client-console --log-stdout-level debug --log-debug 355"'

# Define Editor
export EDITOR=nvim

# -----------------------------------------------------
# Alias
# -----------------------------------------------------

alias c='clear'
alias nf='neofetch'
alias pf='pfetch'
alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'
alias v='$EDITOR'
alias matrix='cmatrix'
alias yu='yay -Syu'
alias yc='packages_to_delete=$(yay -Qdtq);  if [ -z "$packages_to_delete" ]; then echo "Nada que eliminar"; else echo $packages_to_delete; read -p "Eliminar paquetes? (S/N)" choice; if [[ "$choice" == [yYsS] ]]; then yay -Rsn $packages_to_delete; fi; fi'
alias ys='yay -Ss'
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

# -----------------------------------------------------
# GIT
# -----------------------------------------------------

alias gs="git status"
alias gl="git log"
alias ga="git add"
alias gc="git commit -m"
alias gd="git diff"
alias gp="git push"
alias gpl="git pull"
alias gst="git stash"
alias gsp="git stash; git pull"
alias gcheck="git checkout"

# -----------------------------------------------------
# START STARSHIP, para el promt
# -----------------------------------------------------
eval "$(starship init bash)"

export PATH="/usr/lib/ccache/bin/:$PATH"

if [[ $(tty) == *"pts"* ]]; then
  pfetch
fi

lfcd() {
  # `command` is needed in case `lfcd` is aliased to `lf`
  cd "$(command lf -print-last-dir "$@")"
}
