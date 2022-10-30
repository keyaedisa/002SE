#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ -f ~/.bash_profile ]]; then
              . ~/.bash_profile
fi

# Theme PS1
# PS1="\[$(tput setaf 200)\]\u\[$(tput setaf 161)\]@\[$(tput setaf 128)\]\h \[$(tput setaf 219)\]\w \[$(tput sgr0)\]$ "

# Path to bat config
# export BAT_CONFIG_PATH="~/.config/bat/config.conf"


