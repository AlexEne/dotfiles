function open --description 'Open files with default application using xdg-open'
    xdg-open $argv >/dev/null 2>&1 &
end
