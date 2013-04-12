# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
# ZSH_THEME="af-magic"
# ZSH_THEME="alanpeabody"
# ZSH_THEME="bira"
# ZSH_THEME="crunch"
# ZSH_THEME="eastwood"
# ZSH_THEME="muse"
# ZSH_THEME="gurgeh"
ZSH_THEME="gsilk"

# Example aliases
alias zc="e ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# plugins=(rails git ruby rvm)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/home/ersatz/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/home/ersatz/.rvm/bin:/home/ersatz/.rvm/bin:/home/ersatz/.rvm/bin

source ~/.bash_aliases

listsysctls () {
    set -A reply $(sysctl -AN ${1%.*})
}
compctl -K listsysctls sysctl
