function compress --description 'Compress directory or file to tar.gz'
    if test (count $argv) -ne 1
        echo "Usage: compress <directory_or_file>"
        return 1
    end
    
    set -l target (string trim --right --chars=/ $argv[1])
    tar -czf "$target.tar.gz" "$target"
end
