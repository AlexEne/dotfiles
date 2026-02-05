function transcode-video-4K --description 'Transcode video to optimized 4K'
    if test (count $argv) -ne 1
        echo "Usage: transcode-video-4K <video_file>"
        return 1
    end
    
    set -l input $argv[1]
    set -l basename (path change-extension '' $input)
    set -l output "$basename-optimized.mp4"
    
    ffmpeg -i "$input" -c:v libx265 -preset slow -crf 24 -c:a aac -b:a 192k "$output"
end
