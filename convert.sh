#!/bin/bash

input_dir="audio/input"
output_dir="audio/wav"

find "${input_dir}" -type f -iname "*.*" -not -name ".DS_Store" | while read -r input_file; do
    echo "Input file: $input_file"
    output_file="${output_dir}/$(basename "${input_file%.*}")_converted.wav"
    echo "Converting ${input_file} to ${output_file}..."
    ffmpeg -y -hide_banner -loglevel error -i "${input_file}" -acodec pcm_s16le -ar 16000 "${output_file}"
    echo "Done."
done