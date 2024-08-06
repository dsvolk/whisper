upgrade:
	git submodule update --remote
update: upgrade
rec:
	ffmpeg -y -f avfoundation -i ":1" input/rec.mp3
convert:
	./convert.sh
tra_auto:
	./transcribe.sh auto
tra_en:
	./transcribe.sh en
tra_ru:
	./transcribe.sh ru
auto:
	./convert.sh && ./transcribe.sh auto
en:
	./convert.sh && ./transcribe.sh en
ru:
	./convert.sh && ./transcribe.sh ru
cron:
	export VISUAL=nano; crontab -e

# requires yt-dlp:
# https://github.com/yt-dlp/yt-dlp?tab=readme-ov-file#release-files
download:
	./yt-dlp -P ./input/ "$(url)"
d: download