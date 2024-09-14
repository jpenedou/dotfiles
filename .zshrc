HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

autoload -Uz compinit
compinit

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export FZF_CTRL_T_COMMAND='ag --hidden --ignore .git --ignore .cache/yay -l -g ""'
export FZF_ALT_C_COMMAND='find -type d 2>/dev/null'
export FZF_DEFAULT_OPTS='--height 80% --layout=reverse'

# Define Editor
export EDITOR=nvim

# -----------------------------------------------------
# Alias
# -----------------------------------------------------
setopt complete_aliases

alias acee='acestream-engine --client-console --log-stdout-level debug --log-debug 355'
alias acel='acestream-launcher -v -p "mpv" -e "acestream-engine --client-console --log-stdout-level debug --log-debug 355"'
alias bm='bashmount'
alias c='clear'
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'
alias lg='/usr/bin/lazygit'
alias lgd='/usr/bin/lazygit --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias matrix='cmatrix'
alias nf='neofetch'
alias pf='pfetch'
alias v='$EDITOR'
alias yu='yay -Syu'
alias yc='packages_to_delete=$(yay -Qdtq);  if [ -z "$packages_to_delete" ]; then echo "Nada que eliminar"; else echo $packages_to_delete; read -p "Eliminar paquetes? (S/N)" choice; if [[ "$choice" == [yYsS] ]]; then yay -Rsn $packages_to_delete; fi; fi'
alias ys='yay -Ss'
alias -g yi='yay -S'
alias yz='yazi'

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
# key-bindings
# -----------------------------------------------------
bindkey '^ ' autosuggest-accept

# -----------------------------------------------------
# Functions
# -----------------------------------------------------

lfcd() {
  # `command` is needed in case `lfcd` is aliased to `lf`
  cd "$(command lf -print-last-dir "$@")"
}


function yzd() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

eval "$(starship init zsh)"
eval "$(zoxide init bash)"

export PATH="/usr/lib/ccache/bin/:$PATH"

if [[ $(tty) == *"pts"* ]]; then
  pfetch
fi
