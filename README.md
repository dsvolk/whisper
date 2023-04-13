# whisper for MacOS (or Ubuntu, maybe)
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

### Download the model file:
```
cd models
./download-ggml-model.sh large
```

```
cd ../..
```

## Run
### Record an audio:
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
