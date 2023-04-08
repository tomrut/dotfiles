#!/bin/bash
for f in *.3gp
do
    name=`echo "$f" | sed -e "s/.3gp$//g"`
    avconv -i "$f" -vn -ar 44100 -ac 2 -ab 192k -f mp3 "$name.mp3"
done
