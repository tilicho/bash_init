if [[ -r "$HOME/.aliases" ]]; then
    source "$HOME/.aliases"
fi

#fast keyboard key repeat
if command -v xset >/dev/null 2>&1; then
    xset r rate 300 50
fi

ssh_o=$(command -v ssh)
myssh() {
    local status
    if [[ -n "$TMUX" ]]; then
        tmuxoff
    fi
    TERM=screen-256color "$ssh_o" "$@"
    status=$?
    if [[ -n "$TMUX" ]]; then
        tmuxon
    fi
    return $status
}

alias ssh=myssh

move_and_alias() {
    if [[ -d "$1" && -d "$2" ]]; then
        mv "$1" "$2" && ln -s "$2/$(basename "$1")" "$(dirname "$1")"
        echo "Moved '$1' to '$2' and created alias."
    else
        echo "Error: Invalid folder paths."
    fi
}

alias mvln=move_and_alias

#https://zsh-prompt-generator.site
export PROMPT="%F{51}%n%f@%F{41}%m%f %F{yellow}%1d%f>"
export FPP_EDITOR="vim -p"
export ASAN_OPTIONS=abort_on_error=1
export TSAN_OPTIONS=verbosity=1:halt_on_error=1
export EDITOR="nvim"

path_prepend_if_dir() {
    [[ -d "$1" ]] && path=("$1" "${path[@]}")
}

path_append_if_dir() {
    [[ -d "$1" ]] && path+=("$1")
}

typeset -U path
path_prepend_if_dir /opt/homebrew/bin
path_prepend_if_dir "$HOME/.opencode/bin"
path_append_if_dir "$HOME/Library/Python/3.8/bin"
path_append_if_dir "$HOME/.cargo/bin"
path_append_if_dir "$HOME/go/bin"
path_append_if_dir "$HOME/.lmstudio/bin"
export PATH


HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

export KEYTIMEOUT=1
#vi mode (esc, i)
bindkey -v

cursor_insert_='\e[2 q'
cursor_normal='\e[6 q'

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne $cursor_insert_
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne $cursor_normal
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne $cursor_normal
}

zle -N zle-line-init
echo -ne $cursor_normal # Use beam shape cursor on startup.
preexec() { echo -ne $cursor_normal ;} # Use beam shape cursor for each new prompt.

#use lf to switch directory to last visited in lf
lfcd() {
    local dir
    dir="$(lf -print-last-dir)" || return
    [[ -n "$dir" && -d "$dir" ]] || return
    echo "$dir"
    cd -- "$dir" || return
    zle reset-prompt
}
zle -N lfcd
bindkey '^n' lfcd

function vifm-widget() {
  BUFFER="vifm"
  zle accept-line
}
zle -N vifm-widget
bindkey '^o' vifm-widget

# edit line in vim with ctrl+e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line


function view_tmux_pane_in_vim() {
  BUFFER=""
  zle reset-prompt
  if [[ -n "$TMUX" ]] && command -v tmux >/dev/null 2>&1; then
    tmux capture-pane -p | vim + -
  fi
}

zle -N view_tmux_pane_in_vim
bindkey '^r' view_tmux_pane_in_vim

bindkey "$terminfo[kcuu1]" history-beginning-search-backward
bindkey "$terminfo[kcud1]" history-beginning-search-forward
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

bindkey "^j" history-beginning-search-backward
bindkey "^k" history-beginning-search-forward

bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

bindkey '^h' backward-word
bindkey '^l' forward-word

if type brew &>/dev/null
then
    alias far='/Applications/far2l.app/Contents/MacOS/far2l --tty -cd `pwd` -cd `pwd`'
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
else
    autoload -U compinit
fi

zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
  
if [ -e ~/.env ]; then
    source ~/.env
fi

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#[[ ! "$TERM" =~ screen ]] - false if ssh-ed from tmux
  LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS
    if [[ -o interactive ]] \
      && [[ -z "$VSCODE_IPC_HOOK" ]] \
      && [[ -z "$VSCODE_PID" ]] \
      && [[ "$TERM_PROGRAM" != "vscode" ]]; then
          exec tmux
    fi
fi
