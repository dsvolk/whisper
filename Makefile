upgrade:
	git submodule update --remote
update: upgrade
rec:
	ffmpeg -y -f avfoundation -i ":1" audio/input/rec.mp3
convert:
	bash convert.sh
tra_auto:
	bash transcribe_auto.sh
tra_en:
	bash transcribe_en.sh
auto:
	bash convert.sh && bash transcribe_auto.sh
en:
	bash convert.sh && bash transcribe_en.sh
ru:
	bash convert.sh && bash transcribe_ru.sh
cron:
	export VISUAL=nano; crontab -e
