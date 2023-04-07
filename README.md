# whisper
A wrapper for Whisper speech-to-text model by OpenAI

## Install
After you clone the repo, 

1) build whisper.cpp:
```
cd whisper.cpp
make
```

2) download the model file:
```
cd models
./download-ggml-model.sh large
```

3) 
```
cd ../..
```

## Run
1) record an audio:
```
make rec
```

2a) convert the audiofile and do the transcription, language auto-detected:
```
make auto
```

2b) convert the audiofile and do the transcription, language auto-detected and translated to English:
```
make en
```
