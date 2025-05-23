# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/.config/oh-my-zsh

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  auto-notify
  git
  jsontools
  kitty
  ssh
  starship
  web-search
  zoxide
  zsh-autosuggestions
  zsh-bat
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi
export EDITOR=nvim

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

autoload -Uz compinit
compinit

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_CTRL_T_COMMAND='ag --hidden --ignore .git --ignore .cache/yay -l -g ""'
export FZF_ALT_C_COMMAND='find -type d 2>/dev/null'
export FZF_DEFAULT_OPTS='--height 80% --layout=reverse --bind tab:down,shift-tab:up'
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none
  --color=bg+:#2d3f76 \
  --color=bg:#1e2030 \
  --color=border:#589ed7 \
  --color=fg:#c8d3f5 \
  --color=gutter:#1e2030 \
  --color=header:#ff966c \
  --color=hl+:#65bcff \
  --color=hl:#65bcff \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#65bcff \
  --color=query:#c8d3f5:regular \
  --color=scrollbar:#589ed7 \
  --color=separator:#ff966c \
  --color=spinner:#ff007c \
"
export MANROFFOPT="-c" # Para bat, man fix

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
alias ll='eza -al --icons --hyperlink'
alias lt='eza -a --tree --level=1 --icons'
alias lg='lazygit'
alias matrix='cmatrix'
alias nf='neofetch'
alias pf='pfetch'
alias v='nvim'
alias yu='yay -Syu --combinedupgrade --noconfirm'
alias yc='yay -Sc; yay -Yc'
alias ys='yay -Ss'
alias -g yi='yay -S'
alias yz='yazi'

acer() {
    local param="$1"
    if [[ -z "$param" ]]; then
        echo "Por favor, proporciona un acestream-id."
        return 1
    fi
    local url="http://127.0.0.1:6878/remote-control?autoplay=yes&content_id=${param}"
    xdg-open "$url"
}

lgd() {
  lazygit --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"
}

# -----------------------------------------------------
# bindkey
# -----------------------------------------------------
bindkey '^ ' autosuggest-accept
bindkey -v

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

eval "$(atuin init zsh)"

if [[ $(tty) == *"pts"* ]]; then
  pfetch
fi

AUTO_NOTIFY_IGNORE+=("nvim" "yazi" "lazygit" "ping")

# pnpm
export PNPM_HOME="/home/japenedo/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


# Ruta del archivo que almacena la fecha de la última actualización de oh-my-zsh
ZSH_UPDATE_FILE="$ZSH_CACHE_DIR/.zsh-update"

ZSH_UPDATE_LOG="$ZSH_CACHE_DIR/.zsh-update-log"

# Crear el log si no existe
[[ ! -f $ZSH_UPDATE_LOG ]] && touch $ZSH_UPDATE_LOG

# Obtener la fecha actual y la última fecha registrada en el log
LAST_UPDATE=$(cat "$ZSH_UPDATE_FILE" 2>/dev/null || echo "0")
LAST_LOGGED=$(cat "$ZSH_UPDATE_LOG")

# Si hay una nueva actualización, ejecuta el comando para actualizar submodulos de git
if [[ "$LAST_UPDATE" != "$LAST_LOGGED" ]]; then
  echo "Oh My Zsh se ha actualizado. Actualizando custom plugins..."

  dotfiles submodule update --remote --recursive

  # Actualiza el log para no ejecutar el comando varias veces
  echo "$LAST_UPDATE" > "$ZSH_UPDATE_LOG"
fi

# Custom prompt for Yazi
YAZI_TERM=""
if [ -n "$YAZI_LEVEL" ]; then
	YAZI_TERM="|  Yazi terminal: "
fi
PS1="$PS1$YAZI_TERM"
