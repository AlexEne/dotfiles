# Environment Variables
# Global exports for shell environment

# Editor configuration (if not already set)
if not set -q EDITOR
    set -gx EDITOR nvim
end

# Sudo editor (use same as EDITOR)
set -gx SUDO_EDITOR $EDITOR

# Bat theme for syntax highlighting
set -gx BAT_THEME ansi

# Disable command hashing for mise compatibility
# (Fish doesn't use command hashing by default like bash, so this is mostly informational)
