#!/bin/bash

set -e

# http://eyeofmidas.wordpress.com/2014/06/03/how-to-record-desktop-images-into-gif-format-on-ubuntu-14-04/

# TODO: Show some progress
# TODO: Stop for "editing"

output=$1

if [ -z $output ]; then
  echo "Output not provided"
  exit 1
fi

echo $output

mkdir -p /tmp/out/

echo '-----> [1/5] Extracting pngs'
avconv -i /tmp/in/test.avi -vsync 1 -an -y -qscale 1 /tmp/out/out_%04d.png

echo '-----> [2/5] Resizing pngs'
for i in /tmp/out/*.png ; do convert "$i" -resize 50% "$i" ; done

echo '-----> [3/5] Creating gifs'
for i in /tmp/out/*.png ; do convert "$i" "${i%.*}.gif" ; done

echo '-----> [4/5] Creating animated gif'
gifsicle -V --colors 256 --delay=3 --loop /tmp/out/*.gif > /tmp/out/raw.gif

echo '-----> [5/5] Optimizing gif'
convert /tmp/out/raw.gif -fuzz 5% -layers Optimize /tmp/write/$output

