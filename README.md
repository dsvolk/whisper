# 🎙 [Whisper ASR](https://openai.com/research/whisper) for MacOS (or Ubuntu, maybe)
A wrapper for Whisper speech-to-text model by OpenAI. Runs locally on your machine.

## Install
### Install ffmpeg audio conversion tool
```
sudo apt-get install ffmpeg
```

### Clone the repo with it's `whisper.cpp` submodule:
```
git clone --recurse-submodules https://github.com/dsvolk/whisper.git
cd whisper
```

### Build whisper.cpp:
```
cd whisper.cpp
make
```

### Download the Whisper-v2 model file:
```
cd models
./download-ggml-model.sh large-v2
```

Note: you may try using `large-v3` model instead, but I personally observed it hallucinates more than `large-v2`, especially for non-English languages.

```
cd ../..
```

### Download the downloader tool:
From [https://github.com/yt-dlp/yt-dlp](https://github.com/yt-dlp/yt-dlp?tab=readme-ov-file#recommended) , download the appropriate binary executable. Put it in the project root (the top-most `whisper` directory). Rename it `yt-dlp` if it was named otherwise. Give it execution rights:
```
chmod +x yt-dlp
```

## Project structure
- `/input` - this is where you put your original media files, audio or video, in any format.
- `/wav` - media files converted to `.wav` format, required for `whisper`
- `/transcriptions` - transcribed media, in plain `.txt`

## Run
### Input
Put your audio or video file into `/input`. 

Or even record an audio (creates `/input/rec.mp3`):
```
make rec
```
Press `Ctrl+C` to stop recording.

### Transcribe
Option a) convert the audiofile and do the transcription, language auto-detected:
```
make auto
```

Option b) convert the audiofile and do the transcription, language auto-detected and translated to English:
```
make en
```

Option b) convert the audiofile and do the transcription, language auto-detected and translated to Russian:
```
make ru
```
### Output
The transcriptions are put to `transcriptions` folder in plain text `.txt` format.
