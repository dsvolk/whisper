#!/bin/bash

path_to_whisper_main="whisper.cpp/main" # Replace with the absolute path to your whisper main binary
path_to_model="whisper.cpp/models/ggml-large-v2.bin" # Replace with the absolute path to your model
wav_dir="audio/wav"
output_dir="transcriptions"
whisper_flags="--threads 8 --processors 1 --no-timestamps --print-special --print-colors --print-progress"
lang_flags="--language ru"

export path_to_whisper_main
export path_to_model
export whisper_flags
export lang_flags

find "${wav_dir}" -type f -iname "*.wav" -exec bash -c '
    input_file="$1"
    output_file="${2}/$(basename "${input_file%.*}").txt"
    echo "Transcribing ${input_file}..."
    "${path_to_whisper_main}" -m "${path_to_model}" -f "${input_file}" ${whisper_flags} ${lang_flags} | tee "${output_file}"
    echo "Transcribing done."
' _ {} "${output_dir}" \;