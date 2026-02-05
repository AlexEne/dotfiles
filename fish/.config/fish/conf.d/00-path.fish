# PATH Configuration
# Loaded early to ensure paths are available to other scripts

# Add custom bin directory to PATH
fish_add_path $HOME/.local/bin

# Add Cargo/Rust binaries to PATH
fish_add_path $HOME/.cargo/bin

# fish_add_path is idempotent and only prepends if not already in PATH
# It's the fish-native way to manage PATH (better than manual PATH manipulation)
