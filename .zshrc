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

myssh() {
#    function ctrl_c_handle()
#    {
#        echo "ctrl c happened"
#        return 130
#    }
#
#    trap ctrl_c_handle INT

    TERM=screen-256color
    tmuxoff
    ssh "$@"
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

bindkey "$terminfo[kcuu1]" history-beginning-search-backward
bindkey "$terminfo[kcud1]" history-beginning-search-forward
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
  
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

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#[[ ! "$TERM" =~ screen ]] - false if ssh-ed from tmux
  PATH=$PATH:/opt/homebrew/bin:/Users/ser/Library/Python/3.8/bin:$HOME/.cargo/bin
  LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS

  source .env
  exec tmux
fi
