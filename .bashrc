
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
export LC_COLLATE="C"
alias ll='ls -alF --group-directories-first'
alias la='ls -A'
alias l='ls -CF --group-directories-first'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

gohome(){
	cd $GOPATH/src/github.com
}

alias g='cd "$GOPATH/src/github.com/ipfs/go-ipfs"'

function mkcd {

  if [ ! -n "$1" ]; then
    echo "Enter a directory name"
  elif [ -d $1 ]; then
    echo "\`$1' already exists"
  else
    mkdir $1 && cd $1
  fi
}

function supdate {
		
	sudo apt update && sudo apt -y upgrade
}
function enproxy {
	if [ ! -n "$1" ];then
		export http_proxy='http://10.0.0.101:8888'
		export https_proxy='http://10.0.0.101:8888'
		echo $http_proxy
		echo $https_proxy
		wget "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png" -O "/tmp/gglogo.png"
	elif [ "-e" == "$1" ];then
		echo $http_proxy
		echo $https_proxy
		wget "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png" -O "/tmp/gglogo.png"
	else	
		export -n http_proxy
		http_proxy=''
		export -n https_proxy
		https_proxy=''
	fi

}
alias enproxyn='enproxy -n'

function gfind {
	find . -name "*.go" | xargs grep "\<$1\>"
}

if [ -f "$HOME/.bash_ps1" ]; then

     . "$HOME/.bash_ps1"

fi
export HISTCONTROL=ignoreboth:erasedups

export HISTIGNORE='ll:rm *:svn revert*'
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

alias a.='cd ..'
alias ..='cd ../..'
alias ...='cd ../../..'
alias ....='cd ../../../..'

alias gdiff='git difftool .'
alias gstat='git status'

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

export GOROOT=/home/moris/go
export GOPATH=/home/moris/work/goprog
PATH=$GOROOT/bin:/home/moris/work/goprog/bin:$PATH
PATH=/home/moris/work/ipfs/bin/:$PATH

alias vimbashrc='vim ~/.bashrc && source ~/.bashrc'

function mkcd {
	mkdir $1 && cd $1
}

alias vb='vim -M -n'
export GO111MODULE=auto
export ipfs_host='QmYwAPJzv5CZsnA625s3Xf2nemtYgPpHdWEz79ojWnPbdG'
