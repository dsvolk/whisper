#!/bin/bash

# Check if language argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <language>"
    exit 1
fi

language="$1"

export GGML_METAL_PATH_RESOURCES="$(pwd)/whisper.cpp/ggml/src/ggml-metal"

PATH_TO_WHISPER_CLI="whisper.cpp/build/bin/whisper-cli" # Replace with the absolute path to your whisper main binary
PATH_TO_MODEL="whisper.cpp/models/ggml-large-v2-q8_0.bin" # Replace with the absolute path to your model
WAV_DIR="wav"
OUTPUT_DIR="transcriptions"

# if going in loops: add flags:  -mc 0 -nf
WHISPER_FLAGS="--threads 12 --processors 1 --no-timestamps"

LANG_FLAGS="--language ${language}"

# seems useless but Cursor likes it so I'll keep it
export PATH_TO_WHISPER_CLI
export PATH_TO_MODEL
export WHISPER_FLAGS
export LANG_FLAGS

# find "${WAV_DIR}" -type f -iname "*.wav" -exec bash -c '
#     input_file="$1"
#     output_file="${2}/$(basename "${input_file%.*}").txt"
#     echo "Transcribing ${input_file}..."
#     "${PATH_TO_WHISPER_CLI}" -m "${PATH_TO_MODEL}" -f "${input_file}" ${WHISPER_FLAGS} ${LANG_FLAGS} | tee "${output_file}"
#     echo "Transcribing done."
# ' _ {} "${OUTPUT_DIR}" \;

find "${WAV_DIR}" -type f -iname "*.wav" -exec bash -c '
    input_file="$1"
    output_file="${2}/$(basename "${input_file%.*}").txt"
    temp_file="${input_file}.transcription_done"

    echo "Transcribing ${input_file}..."
    if "${PATH_TO_WHISPER_CLI}" -m "${PATH_TO_MODEL}" -f "${input_file}" ${WHISPER_FLAGS} ${LANG_FLAGS} | tee "${output_file}"; then
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
' _ {} "${OUTPUT_DIR}" \;