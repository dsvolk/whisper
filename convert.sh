#!/bin/bash

input_dir="audio/input"
output_dir="audio/wav"

find "${input_dir}" -type f -iname "*.*" -not -name ".DS_Store" | while read -r file; do
    base_input_file="${file##*/}"
    input_file="${input_dir}/${base_input_file}"
    output_file="${output_dir}/${base_input_file}.wav"
    echo "Converting ${input_file} to ${output_file}..."
    ffmpeg -y -hide_banner -loglevel error -i "${input_file}" -acodec pcm_s16le -ar 16000 "${output_file}"
    echo "Done."
done