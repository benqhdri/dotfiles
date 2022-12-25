# alias for cygwin
alias get="/cygdrive/c/cygwin64/setup-x86_64.exe -q -P"
alias s="cygstart"
alias clion="clion64"
alias idea="idea64"

set -o vi                           # use vim as default

# history config
HISTCONTROL=ignoredups
HISTSIZE=2001
HISTFILESIZE=2001
shopt -s histappend                 # append to the history file, don't overwrite it

# common alias
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias c='clear'
alias h='history'
alias tree='tree --dirsfirst -F'
alias mkdir='mkdir -p -v'

# ll
alias l='ls --color'                        # list files
alias ls='ls --color'                        # list files
alias l.='ls -d .* --color'                 # list hidden files
alias ll='ls -lhrt --color'                 # extra info compared to "l"
alias lld='ls -lUd */ --color'              # list directories
alias la='ls -a --color'                    # list hidden files

# git commands
alias gs='git status'
alias gb='git branch -a'
alias gc='git checkout'
alias gd='git diff'
alias gl='git log --all --graph --decorate --oneline'

# colors
blk='\[\033[01;30m\]'   # Black
red='\[\033[01;31m\]'   # Red
grn='\[\033[01;32m\]'   # Green
ylw='\[\033[01;33m\]'   # Yellow
blu='\[\033[01;34m\]'   # Blue
pur='\[\033[01;35m\]'   # Purple
cyn='\[\033[01;36m\]'   # Cyan
wht='\[\033[01;37m\]'   # White
clr='\[\033[00m\]'      # Reset

# add git branch in prompt
git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
if [ "`id -u`" -eq 0 ]; then
    # root as #, else as $
    PS1="${grn}\u@\h ${ylw}\w ${red}\$(git_branch)${clr}\n# "
else
    PS1="${grn}\u@\h ${ylw}\w ${red}\$(git_branch)${clr}\n$ "
fi

clear
