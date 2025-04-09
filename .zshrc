alias grep='grep --color=always'
alias py=python3
alias shutdown='sudo shutdown -f now'
alias less='less -r'
#alias ls='exa'
alias diff='nvim -d'
alias nvim='nvim -u ~/.vimrc'
alias vim='nvim -u ~/.vimrc'
alias vi='nvim -u ~/.vimrc'
alias rsync='/opt/homebrew/Cellar/rsync/3.2.4/bin/rsync'
alias psaux='ps axo user:20,pid,pcpu,pmem,vsz,rss,tty,stat,start,time,comm'
alias wgetc='wget -c --progress=bar '

alias tmuxoff='tmux set prefix None && tmux set key-table off && tmux set status-style "fg=colour245,bg=colour238" && tmux set window-status-current-style "fg=colour232,bold,bg=colour254" && tmux refresh-client -S'

alias tmuxon='tmux set -u prefix && tmux set -u key-table && tmux set -u status-style && tmux set -u window-status-current-style && tmux refresh-client -S'

#fast keyboard key repeat
set x rate 300 50
ssh_o=`which ssh`
myssh() {
    TERM=screen-256color
    tmuxoff
    $ssh_o "$@"
    tmuxon
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
    dir="$(lf -print-last-dir)"
    echo $dir
    cd $dir
}
zle -N lfcd
bindkey '^o' lfcd


# edit line in vim with ctrl+e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

bindkey "$terminfo[kcuu1]" history-beginning-search-backward
bindkey "$terminfo[kcud1]" history-beginning-search-forward
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

bindkey "^j" history-beginning-search-backward
bindkey "^k" history-beginning-search-forward

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
  PATH=$PATH:/opt/homebrew/bin:/Users/ser/Library/Python/3.8/bin:$HOME/.cargo/bin
  LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS
  exec tmux
fi
