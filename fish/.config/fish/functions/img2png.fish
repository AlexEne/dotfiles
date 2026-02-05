function img2png --description 'Transcode image to compressed-but-lossless PNG'
    if test (count $argv) -lt 1
        echo "Usage: img2png <image_file> [additional_magick_options...]"
        return 1
    end
    
    set -l img $argv[1]
    set -l basename (path change-extension '' $img)
    set -l output "$basename-optimized.png"
    
    # Get any additional arguments beyond the first
    set -l extra_args $argv[2..-1]
    
    magick "$img" $extra_args -strip \
        -define png:compression-filter=5 \
        -define png:compression-level=9 \
        -define png:compression-strategy=1 \
        -define png:exclude-chunk=all \
        "$output"
end
