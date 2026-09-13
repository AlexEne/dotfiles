# ~/.bashrc — minimal (de-omarchified)

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Prompt
eval "$(starship init bash)"

export PATH=$HOME/.local/bin:$PATH
