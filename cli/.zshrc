path+=$HOME/bin
path+=$HOME/.local/bin
path+=$HOME/.cargo/bin
export PATH

source <(antibody init)
antibody bundle < ~/.config/zsh/plugins.txt

zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -Uz compinit
compinit
COMPLETION_WAITING_DOTS="true"
setopt COMPLETE_ALIASES

# Prompt
SPACESHIP_VI_MODE_COLOR="green"
SPACESHIP_VI_MODE_NORMAL="[CMD]"
SPACESHIP_VI_MODE_INSERT="INPUT"
SPACESHIP_VI_MODE_SUFFIX=""
SPACESHIP_CHAR_SYMBOL="// "
SPACESHIP_USER_SHOW="needed"
setopt interactivecomments

# History and search
HISTFILE=~/.zsh_history
SAVEHIST=10000
HISTSIZE=10000
setopt SHARE_HISTORY
setopt HIST_FIND_NO_DUPS
setopt EXTENDED_HISTORY
export HISTTIMEFORMAT="[%F %T] "

# Completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Environment
export EDITOR='/usr/bin/nvim'
export VISUAL='/usr/bin/nvim'
export CHEAT_EDITOR='/usr/bin/nvim'
export BAT_THEME='ansi'
if type batcat > /dev/null; then
    export LESSOPEN="| batcat --color=always -p %s"
    export LESS=" -R "
elif type bat > /dev/null; then
    export LESSOPEN="| bat --color=always -p %s"
    export LESS=" -R "
fi

# Vi-mode
spaceship_vi_mode_enable
bindkey -v # just to be thorough
export KEYTIMEOUT=1

# Key binds
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word
bindkey "^H" backward-delete-char
bindkey "^U" backward-kill-line

# source other config files
source $HOME/.config/zsh/alias.zsh
if [ -f ~/.config/zsh/host.zsh ]; then
    source $HOME/.config/zsh/host.zsh
fi
