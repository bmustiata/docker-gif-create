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

if [ -z $scaling ]; then
    scaling=="1.0"
fi

echo $output

mkdir -p /tmp/out/

echo '-----> [1/5] Extracting pngs'
avconv -i /tmp/in/test.avi -vsync 1 -an -y -qscale 1 /tmp/out/out_%05d.png

echo '-----> [2/2] Creating the GIF'
gimp -i --batch-interpreter=python-fu-eval -b "pdb.python_fu_create_gif('/tmp/out', '/tmp/final.gif', '1.0')" -b "pdb.gimp_quit(1)"

cp /tmp/final.gif /tmp/write/$output

