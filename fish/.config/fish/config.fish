# ~/.config/fish/config.fish
# Main fish shell configuration
#
# This configuration is organized into modular files:
# - conf.d/*.fish: Auto-loaded configuration snippets
# - functions/*.fish: Auto-loaded functions on-demand
#
# Files in conf.d/ are loaded in alphabetical order:
# 00-path.fish    -> PATH modifications
# 01-env.fish     -> Environment variables
# 02-tools.fish   -> Tool initialization (mise, starship, zoxide, etc.)
# 03-omarchy.fish -> Omarchy-style aliases

# If not running interactively, don't do anything
status is-interactive; or return

# Disable the default greeting message
set -g fish_greeting

# Fish has excellent defaults for:
# - History (shared across sessions, smart deduplication)
# - Autosuggestions (suggests commands from history)
# - Syntax highlighting (built-in)
# - Tab completion (context-aware)

# Add your custom configuration below this line
# Example:
# set -gx EDITOR nvim
# alias myalias='command'
