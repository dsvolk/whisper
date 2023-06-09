#!/bin/bash

wav_dir="audio/wav"
output_dir="transcriptions"

find "${wav_dir}" -type f -iname "*.wav" | while read -r input_file; do
    echo "Transcribing ${input_file}..."
    ./whisper.cpp/main -m whisper.cpp/models/ggml-large.bin -f "$input_file" -nt -l auto | tee "${output_dir}/$(basename "${input_file%.*}").txt"
    echo "Transcribing done."
done