function zd --description 'Smart cd with zoxide integration'
    # If no arguments, go to home directory
    if test (count $argv) -eq 0
        builtin cd ~
        return
    end
    
    # If argument is a directory, use regular cd
    if test -d $argv[1]
        builtin cd $argv[1]
    else
        # Otherwise, use zoxide for smart jumping
        if type -q z
            z $argv
            and printf "\U000F17A9 "
            and pwd
        else
            echo "Error: Directory not found"
            return 1
        end
    end
end
