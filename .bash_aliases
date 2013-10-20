# ========== git ==========
alias amend="git commit -a --amend"
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gca="git commit --amend"
alias gcb="git checkout -b"
alias gcm="git commit -a -m"
alias gcn="git clean -n"
alias gd="git diff"
alias gdc="git diff --cached"
alias gds="git diff --stat"
alias gf="emacs -nw ~/.gitconfig"
alias gi="sudo gem install"
alias gl="git log"
alias glr="gem list --remote"
alias gp="git push"
alias gpl="git pull"
alias gplr="git pull --rebase"
alias gpom="git pull origin master"
alias gpum="git push origin master"
alias gsi="git submodule init"
alias gsp="git stash pop"
alias gst="git status"
alias gsu="git submodule update"

# ========== other ==========
alias a="apt-cache search --names-only"
alias b="cd -"
alias brc="emacs -nw ~/.bashrc"
alias df="df -h"
alias e="emacs -nw"
alias i="sudo apt-get install -y"
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ly="lynx -lss ~/prefix/lynx.lss -tna -cookies -cfg ~/prefix/lynx.cfg http://www.google.com"
alias m="mysql"
alias mc="make clean"
alias nb="newsbeuter"
alias p="popd"
alias pi="sudo python setup.py install"
alias pms="python -m SimpleHTTPServer"
alias py="python"
alias r="rails"
alias rc="rails console"
alias rd="google-chrome /home/gsilk/extern/rails/doc/rdoc/index.html /var/lib/gems/1.9.1/gems/railties-3.2.6/guides/output/index.html"
alias rdm="rake db:migrate"
alias rg="rails generate"
alias rgc="rails generate controller"
alias rgm="rails generate migration"
alias rm="rm -i"
alias rs="rails server"
alias ru="ruby"
alias s="source ~/.zshrc"
alias sb="sqlitebrowser"
alias sc="screen"
alias stp="sudo strace -f -ttT -o ~/\`date +%Y_%m_%d_%H:%M:%S.strace\` -p"
alias t="tar -czf"
alias u="cd .."
alias wg="wget"
alias x="tar xzvf"

# ========== common typos ==========
alias xs="cd"
alias vf="cd"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
