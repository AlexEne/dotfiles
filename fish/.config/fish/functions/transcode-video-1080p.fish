function transcode-video-1080p --description 'Transcode video to optimized 1080p'
    if test (count $argv) -ne 1
        echo "Usage: transcode-video-1080p <video_file>"
        return 1
    end
    
    set -l input $argv[1]
    set -l basename (path change-extension '' $input)
    set -l output "$basename-1080p.mp4"
    
    ffmpeg -i "$input" -vf scale=1920:1080 -c:v libx264 -preset fast -crf 23 -c:a copy "$output"
end
