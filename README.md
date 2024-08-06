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

### Clone this repository with it's `whisper.cpp` submodule:
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

### Return to the project root:
```
cd ../..
```

### (Optional) Download the downloader tool:
From [yt-dlp](https://github.com/yt-dlp/yt-dlp?tab=readme-ov-file#recommended), download the appropriate binary executable. Put it in the project root (the top-most `whisper` directory). Rename it `yt-dlp` if it was named otherwise. Give it execution rights:
```
chmod +x yt-dlp
```

Note: you may, of course, instead use your own favorite tool to download media files, like `youtube-dl` or `wget` or any other.

## Project structure
After the installation, the project structure should look like this:
```
whisper
├── input/                 # Your original media files, audio or video, in any format.
│   ├── ...            
├── wav/                   # The converted media files, in .wav format.
│   ├── ...                
├── transcriptions/        # Transcribed media, in plain text format.
│   ├── ...                
├── yt-dlp                 # yt-dlp tool for downloading media (optional).
├── whisper.cpp            # Whisper lives here.
└── ...                    # Other auxiliary files.
```

## Run
The project is designed to be run in three steps, explained below in detail:
1. download media files and put them into `input` directory
2. convert all the files from `input` directory to wav files in `wav` directory, overwriting if necessary. 
3. transcribe each file in `wav` directory, using one of the language settings: `auto`, `en`, `ru`. 

Make sure you remove the original files from `input` when you transcribed them already, otherwise they will be transcribed again. I decided to not to remove the files automatically and leave it to the user, to avoid accidental deletion of valuable files.

Files in `wav` directory are automatically removed after transcription, as they are very easy to regenerate.

### 1. Download media files
You can download media files using the `yt-dlp` tool, or any other tool you prefer. If you use `yt-dlp`, I provided you a helpful command to download the media files into `input` directory:
```
make d url="https://www.youtube.com/watch?v=pP44EPBMb8A"
```
Replace the URL with the one you want to download.

#### .. or record your own audio
You can even record your own audio (creates `input/rec.mp3`):
```
make rec
```
Press `Ctrl+C` to stop recording.

### 2. & 3. Convert the media files and transcribe all of them
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

You can also do the convert and transcribe steps separately, if you want to, for example:
```
./convert.sh
./transcribe.sh auto
```

### Output
The transcriptions are put to `transcriptions` folder in plain text `.txt` format.

### Complete example of a run
```
make d url="https://www.youtube.com/watch?v=pP44EPBMb8A"
make auto
```
Voilà! You have the transcription in `transcriptions` directory.

## Credits
- [OpenAI](https://openai.com/research/whisper) for the Whisper ASR model
- [whisper.cpp](https://github.com/ggerganov/whisper.cpp) and personally [@ggerganov](https://github.com/ggerganov) for the C++ wrapper for Whisper
- [yt-dlp](https://github.com/yt-dlp/yt-dlp?) for the downloader tool

## Disclaimers

1. **As-Is Provision**: This software is provided "as is," without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose, and noninfringement. In no event shall the author or contributors be held liable for any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the software or the use or other dealings in the software.

2. **Usage Rights**: The software is available for both private and commercial use.

3. **Liability Disclaimer**: The author does not take any responsibility for any damage that may result from using this software. Users are solely responsible for determining the appropriateness of using the software and assume any risks associated with its use.

4. **Modification and Licensing**: You are allowed to modify the software under the terms of the MIT License. Contributions are welcome, and pull requests are highly encouraged.

5. **Errors and Glitches**: The software is likely to contain some glitches and errors. Users are encouraged to report any issues and are very welcome to submit pull requests to fix them.

6. **Enjoyment Clause**: We hope you enjoy using the software and find it useful!
