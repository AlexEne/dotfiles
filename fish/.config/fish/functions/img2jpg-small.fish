function img2jpg-small --description 'Transcode image to small optimized JPG for web'
    if test (count $argv) -lt 1
        echo "Usage: img2jpg-small <image_file> [additional_magick_options...]"
        return 1
    end
    
    set -l img $argv[1]
    set -l basename (path change-extension '' $img)
    set -l output "$basename-optimized.jpg"
    
    # Get any additional arguments beyond the first
    set -l extra_args $argv[2..-1]
    
    magick "$img" $extra_args -resize '1080x>' -quality 95 -strip "$output"
end
