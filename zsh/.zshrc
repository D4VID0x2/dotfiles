# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/david/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="intheloop"
#gentoo  - jako bash
#essembeh - jako bash
#dpoggi - jako bash, ale barevnejsi
#kennethreitz - pwd na prave strane
#bira - $ na nove radce pod pwd
#rkj - old tech style
#intheloop - $ na nove radce, mezera mezi prikazy

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

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=21

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting fzf-zsh-plugin)

source $ZSH/oh-my-zsh.sh

# User configuration

#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666,underline"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

bindkey '^ ' autosuggest-accept  # accept suggestion with ctrl-space

export EDITOR='lvim'
export TERM=screen-256color
export PATH=$PATH:/home/david/.local/bin:/home/david/.dotnet/tools

if [ -f ~/.config/shell_aliases ]; then
    source ~/.config/shell_aliases
fi

setopt GLOBdots

eval $(thefuck --alias)

if command -v pazi &>/dev/null; then
  eval "$(pazi init zsh)" # or 'bash'
fi
alias zf='z --pipe="fzf"'

# Command time
function preexec() {
  timer=$(($(date +%s%0N)/1000000))
}

function precmd() {
  if [ $timer ]; then
    now=$(($(date +%s%0N)/1000000))
    elapsed=$(($now-$timer))

    ms=$(($elapsed % 1000))
    sec=$(($elapsed/1000 % 60))
    min=$(($elapsed/60000 % 60))
    hour=$(($elapsed/3600000))

    if [ "$elapsed" -le 1000 ]; then
        export RPROMPT="%F{cyan} $(printf "%d ms" $ms) %{$reset_color%}"
    elif [ "$elapsed" -gt 1000 ] && [ "$elapsed" -le 60000 ]; then
        export RPROMPT="%F{cyan} $(printf "%d.%03d s" $sec $ms) %{$reset_color%}"
    elif [ "$elapsed" -gt 60000 ] && [ "$elapsed" -le 3600000 ]; then
        export RPROMPT="%F{yellow} $(printf "%d min. %d s" $min $sec) %{$reset_color%}"
    else
        export RPROMPT="%F{red} $(printf "%d hours %d min. %d s" $hour $min $sec) %{$reset_color%}"
    fi

    unset timer
  fi
}


#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjvf $1  ;;
      *.tar.gz)    tar xzvf $1  ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xvf $1   ;;
      *.tbz2)      tar xjvf $1  ;;
      *.tgz)       tar xzvf $1  ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

