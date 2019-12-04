# ~/.bashrc: executed by bash(1) for non-login shells.
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

bold=$(tput bold)
yellow='\033[1;33m'
normal=$(tput sgr0)
nc='\033[0m'

if [ "$color_prompt" = yes ]; then
    PS1='[ ${debian_chroot:+($debian_chroot)}\[\033[38;5;226m\]\e[1m\w\e[0m\[\033[00m\] ]\n➤ '
    #PS1='┌[ ${debian_chroot:+($debian_chroot)}\[\033[38;5;226m\]\e[1m\w\e[0m\[\033[00m\] ]\n└──> '
    #PS1='[ ${debian_chroot:+($debian_chroot)}\w ]\n➤ '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n└──> '
else
    #PS1='[ \u:\w  ]\n➤ '
    PS1='[ \w ]\n➤ '
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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

trap 'echo -ne "\e[0m"' DEBUG

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

# aliases
alias gst-launch="gst-launch-1.0"
alias looky="grep --exclude='*.min.*' -r"
alias speed='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -'
alias ag='ag --ignore build/intermediates/'
alias qq='ll'
alias wifi-off="nmcli radio wifi off"
alias wifi-on="nmcli radio wifi on"
alias reset-wifi="nmcli radio wifi off && sleep 5 && ncli radio wifi on"
alias rshift="redshift -O 3500 &"
alias localscan="nmap -sPR 192.168.0.1/24"
alias gb='go build'
alias nmap='nmap -v'
alias bcurl='curl -A "Brozilla/5.0 (Windows NT 6.1; Win64; x64; rv:59.0) Gecko/20100101 LizzieMcGuirefox/59.0"'
alias top='htop'
alias ll='tree -L 1 -I "*.pyc|__pycache__"'
alias lk='ls -thor'
alias vimk="vim -c 'NEK'"
#alias python='bpython'
alias vim='nvim'
alias lll='ls -thor'
alias l='ls -thorg'
alias gti='git'
alias cat='~/custom/ccat/ccat --bg=dark'
alias shc='~/custom/shc/src/shc'
alias la='ls -A'
alias l='ls -CF'
alias rm='rm -f'
alias gr='grep -r'
alias dups="find . ! -empty -type f -exec md5sum {} + | sort | uniq -w32 -dD"
alias kk="ls -thorg"
alias 1='cd ../'
alias 2='cd ../../'
alias 3='cd ../../../'
alias 4='cd ../../../../'
alias 5='cd ../../../../../'
alias micro='~/custom/micro'
alias dirsize="du -sh ./*"
alias 8675309="confirm sudo rm -rf /home/$USER/*"
alias stonks="echo 'One sec plz...' && wget -q https://raw.githubusercontent.com/pstadler/ticker.sh/master/ticker.sh && chmod +x ticker.sh && ./ticker.sh AAPL && rm ./ticker.sh"

if [ "$OSTYPE" == "linux-gnu" ]; then
    alias asdfasdf="systemctl suspend"
    alias open='xdg-open'
elif [ "$OSTYPE" == "darwin"* ]; then
    alias asdfasdf="pmset sleepnow"
fi

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

#source /opt/ros/melodic/setup.bash
confirm() {
    echo -n "Do you want to run \"$*\"? [N/y] "
    read -N 1 REPLY
    echo
    if test "$REPLY" = "y" -o "$REPLY" = "Y"; then
        "$@"
    else
        echo "Cancelled by user"
    fi
}

export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
