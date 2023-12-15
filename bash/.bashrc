#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\n\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ '

stty -ixon # Disable Ctrl-s and Ctrl-q
HISTSIZE=1000

if [ -f ~/.shell_aliases ]; then
    source ~/.shell_aliases
fi

export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.pub-cache/bin

export EDITOR='lvim'

#source "$HOME/.cargo/env"

tmux
