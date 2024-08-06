#!/bin/bash

input_dir="input"
output_dir="wav"

# Create the output directory if it does not exist
mkdir -p "$output_dir"

find "${input_dir}" -type f -iname "*.*" -not -name ".DS_Store" -not -name ".gitkeep" -print0 | while IFS= read -r -d $'\0' file; do
    base_input_file="$(basename -- "$file")"
    base_output_file="${base_input_file%.*}.wav"
    output_file="${output_dir}/${base_output_file}"
    echo "Converting \"$file\" to \"$output_file\"..."
    
    # Run ffmpeg and check its exit status
    if ffmpeg -y -hide_banner -loglevel error -i "$file" -acodec pcm_s16le -ar 16000 "$output_file" </dev/null; then
        echo "Done."
    else
        echo "Failed to convert $file" >&2
    fi
done