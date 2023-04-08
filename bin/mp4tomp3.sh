#!/bin/bash
for f in *.mp4; do ffmpeg -i "$f" -vn -c:a libmp3lame -ar 44100 -ac 2 -ab 192k "${f/%mp4/mp3}"; done
