# Tool Initialization
# Initialize CLI tools that enhance the shell experience
# Only initialize if the tool is installed

# Mise: Multi-language version manager (like asdf/nvm)
if type -q mise
    mise activate fish | source
end

# Starship: Cross-shell prompt
if type -q starship
    starship init fish | source
end

# Zoxide: Smart directory jumper (enhanced cd)
if type -q zoxide
    zoxide init fish | source
end

# Try: Sandbox for testing commands
# Note: 'try' only supports bash/zsh, not fish
# If you need 'try' functionality, run it from bash or create a fish wrapper function

# FZF: Fuzzy finder key bindings
# Note: You may need to install fzf.fish plugin for full integration
# Install with: fisher install PatrickF1/fzf.fish
if type -q fzf
    # Try to load system fzf key bindings if available
    if test -f /usr/share/fzf/key-bindings.fish
        source /usr/share/fzf/key-bindings.fish
    end
    
    # Arch Linux fzf package may install to different location
    if test -f /usr/share/fish/vendor_functions.d/fzf_key_bindings.fish
        fzf_key_bindings
    end
end
