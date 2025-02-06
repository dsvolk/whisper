#!/bin/bash

# Check if language argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <language>"
    exit 1
fi

language="$1"

path_to_whisper_main="whisper.cpp/main" # Replace with the absolute path to your whisper main binary
path_to_model="whisper.cpp/models/ggml-large-v2-q8_0.bin" # Replace with the absolute path to your model
wav_dir="wav"
output_dir="transcriptions"
whisper_flags="--threads 6 --processors 1 --no-timestamps"
lang_flags="--language ${language}"

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

find "${wav_dir}" -type f -iname "*.wav" -exec bash -c '
    input_file="$1"
    output_file="${2}/$(basename "${input_file%.*}").txt"
    temp_file="${input_file}.transcription_done"

    echo "Transcribing ${input_file}..."
    if "${path_to_whisper_main}" -m "${path_to_model}" -f "${input_file}" ${whisper_flags} ${lang_flags} | tee "${output_file}"; then
        touch "${temp_file}"
        echo "Transcribing done."
    else
        echo "Transcription failed for ${input_file}."
    fi

    if [ -f "${temp_file}" ]; then
        rm "${input_file}"
        rm "${temp_file}"
        echo "Removed ${input_file}."
    fi
' _ {} "${output_dir}" \;