# Add user configurations here
# For HyDE to not touch your beloved configurations,
# we added 2 files to the project structure:
# 1. ~/.user.zsh - for customizing the shell related hyde configurations
# 2. ~/.zshenv - for updating the zsh environment variables handled by HyDE // this will be modified across updates

#  Plugins 
# oh-my-zsh plugins are loaded  in ~/.hyde.zshrc file, see the file for more information
#

# restore_alsa() {
#  while [ -z "$(pidof pulseaudio)" ]; do
#   sleep 0.5
#  done
#  alsactl -f /var/lib/alsa/asound.state restore
# }
# restore_alsa &

#  Aliases 
# Add aliases here
alias rm='trash -i'
alias ff='fastfetch'
alias v='nvim .'
alias ls='ls -a --color=auto'
alias lg='lazygit'
alias grep='grep --color=auto'
alias q='exit'
alias du='du -h'

#  This is your file 
# Add your configurations here
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
export EDITOR=nvim
export LD_LIBRARY_PATH=~/MultiNest/lib/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$HOME/miktex_boost/usr/lib/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$HOME/miktex_boost/icu/usr/lib/:$LD_LIBRARY_PATH

# export LD_LIBRARY_PATH=~/exoplanet_atmospheres/.venv/cuba/:$LD_LIBRARY_PATH

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# export QT_LOGGING_RULES="qt.qpa.*=false"
 
function mktouch {
  mkdir -p "$(dirname "$1")" && touch "$1"
}

function cds {
    cd $1 && source $HOME/$1'/.venv/bin/activate' 
}

function pdf {
    zathura $1 & disown
}

unset -f command_not_found_handler # Uncomment to prevent searching for commands not found in package manager
