#
# ~/.bashrc
#
sleep 0.02
fastfetch 
# If not running interactively, don't do anything
[[ $- != *i* ]] && return


cursor='\[\e[1;m\e[1;33m\][\u : \W] $ \[\e[m\e[m\]'
export PS1=$cursor

export LD_LIBRARY_PATH=/home/danny/exoplanet_atmospheres/.venv/MultiNest/lib/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/home/danny/wvkbd/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/home/danny/exoplanet_atmospheres/.venv/cuba/:$LD_LIBRARY_PATH
export GSK_RENDERER=gl

alias rm='rm -i'
# alias vim='nvim'
alias v='nvim .'
alias ls='ls -a --color=auto'
alias lg='lazygit'
alias grep='grep --color=auto'
alias c='clear'
alias q='exit'

function cds {
    cd $1 && source $1'.venv/bin/activate' 
}

function wp {
    swww img --resize $2 $1 --transition-fps 60 --transition-type any && wal -i $1
}

#alias "cd exoplanet_atmospheres/"='cd ~/exoplanet_atmospheres/ && source ~/exoplanet_atmospheres/.venv/bin/activate'

# Created by `pipx` on 2025-07-04 16:11:11
export PATH="$PATH:/home/danny/.local/bin"
