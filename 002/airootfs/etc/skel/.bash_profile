#
# ~/.bash_profile
#

## User env + startup programs

export PS1="\[$(tput setaf 200)\]\u\[$(tput setaf 161)\]@\[$(tput setaf 128)\]\h \[$(tput setaf 219)\]\w \[$(tput setaf 161)\]$ "


## Get aliases

if [[ -f ~/.bash_aliases ]]; then
			 . ~/.bash_aliases
fi

## Ignore upper and lowercase when TAB completion
bind 'set completion-ignore-case on'

neofetch
