# 🎙 [Whisper ASR](https://openai.com/research/whisper) for MacOS (or Ubuntu, maybe)
A wrapper for Whisper speech-to-text model by OpenAI. Runs locally on your machine.

Allows you to download and transcribe media files from the internet, as simple as
```
make d url="https://www.youtube.com/watch?v=pP44EPBMb8A"
make auto
```

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

### (Optional) Download the downloader tool:
From [https://github.com/yt-dlp/yt-dlp](https://github.com/yt-dlp/yt-dlp?tab=readme-ov-file#recommended) , download the appropriate binary executable. Put it in the project root (the top-most `whisper` directory). Rename it `yt-dlp` if it was named otherwise. Give it execution rights:
```
chmod +x yt-dlp
```

Note: you may, of course, instead use your own favorite tool to download media files, like `youtube-dl` or `wget` or any other.

## Project structure
- `/input` - this is where you put your original media files, audio or video, in any format.
- `/wav` - media files converted to `.wav` format, required for `whisper`
- `/transcriptions` - transcribed media, in plain `.txt`

## Run
1. you download the media files and put them into `/input` directory
2. it converts all the files from `/input` directory to wav files in `/wav` directory, overwriting if necessary. 
3. it transcribes each file in `/wav` directory, using one of the language settings: `auto`, `en`, `ru`. 

Make sure you remove the original files from `/input` when you transcribed them already, otherwise they will be transcribed again. I decided to not to remove the files automatically and leave it to the user, to avoid accidental deletion of valuable files.

Files in `/wav` directory are automatically removed after transcription, as they are very easy to regenerate.

### 1. Download media files
You can download media files using the `yt-dlp` tool, or any other tool you prefer. If you use `yt-dlp`, I provided you a helpful command to download the media files into `/input` directory:
```
make d url="https://www.youtube.com/watch?v=pP44EPBMb8A"
```
Replace the URL with the one you want to download.

#### .. or record your own audio
You can even record your own audio (creates `/input/rec.mp3`):
```
make rec
```
Press `Ctrl+C` to stop recording.

### Convert the media files and transcribe all of them
I provide handy shortcuts for you to convert and transcribe the media files in one go.
Auto-detect the language of each file and transcribe it:
```
make auto
```

Transcribe each file in English:
```
make en
```

Transcribe each file in Russian:
```
make ru
```

You can use your own language tag, if you know it, like `de` for German, `fr` for French, etc., for example:
```
./convert.sh && ./transcribe.sh de
```

### Output
The transcriptions are put to `transcriptions` folder in plain text `.txt` format.

### Complete example of a run
```
make d url="https://www.youtube.com/watch?v=pP44EPBMb8A"
make auto
```
Voilà! You have the transcription in `/transcriptions` directory.

## Credits
- [OpenAI](https://openai.com/research/whisper) for the Whisper ASR model
- [whisper.cpp](https://github.com/ggerganov/whisper.cpp) and personally [@ggerganov](https://github.com/ggerganov) for the C++ wrapper for Whisper
- [yt-dlp](https://github.com/yt-dlp/yt-dlp?) for the downloader tool
