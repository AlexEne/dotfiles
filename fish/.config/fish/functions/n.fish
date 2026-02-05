function n --description 'Open neovim, current directory if no arguments'
    if test (count $argv) -eq 0
        nvim .
    else
        nvim $argv
    end
end
