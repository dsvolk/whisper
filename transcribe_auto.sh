#!/bin/bash

wav_dir="audio/wav"
output_dir="transcriptions"

find "${wav_dir}" -type f -iname "*.wav" -exec bash -c '
    input_file="$1"
    output_file="${2}/$(basename "${input_file%.*}").txt"
    echo "Transcribing ${input_file}..."
    ./whisper.cpp/main -m whisper.cpp/models/ggml-large-v3.bin -f "${input_file}" -nt -l auto | tee "${output_file}"
    echo "Transcribing done."
' _ {} "${output_dir}" \;