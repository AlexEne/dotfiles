# Omarchy-style Aliases
# Ported from Omarchy bash configuration
# All the default Omarchy aliases for enhanced CLI experience

# Only load in interactive shells
status is-interactive; or return

# ===== File System =====

# Enhanced ls using eza (modern ls replacement)
if type -q eza
    alias ls='eza -lh --group-directories-first --icons=auto'
    alias lsa='ls -a'
    alias lt='eza --tree --level=2 --long --icons --git'
    alias lta='lt -a'
end

# Fuzzy file finder with bat preview
if type -q fzf; and type -q bat
    alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
end

# ===== Directory Navigation =====

# Quick parent directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Smart cd with zoxide integration (if zoxide is installed)
if type -q zoxide
    alias cd='zd'
end

# Note: zd function is defined in functions/zd.fish

# ===== Tool Shortcuts =====

alias c='opencode'
alias d='docker'
alias r='rails'

# Note: n function (nvim shortcut) is defined in functions/n.fish

# ===== Git Shortcuts =====

alias g='git'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'

# ===== Compression =====

# Note: compress/decompress functions are defined in functions/ directory
alias decompress='tar -xzf'
