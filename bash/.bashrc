eval "$(starship init bash)"

# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'
#. "$HOME/.cargo/env"
export PATH=$HOME/.local/bin:$PATH

#eval "$(oh-my-posh init bash)"
#eval "$(oh-my-posh init bash --config 'https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/catppuccin_mocha.omp.json')"
