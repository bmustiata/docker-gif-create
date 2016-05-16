#!/bin/bash

set -e

output=$1
scaling=$2

if [ -z $output ]; then
  echo "Output not provided"
  exit 1
fi

if [ -z $scaling ]; then
    scaling=="1.0"
fi

echo $output

mkdir -p /tmp/out/

echo '-----> [1/2] Extracting pngs'
avconv -i /tmp/in/test.avi -vsync 1 -an -y -qscale 1 /tmp/out/out_%05d.png

echo '-----> [2/2] Creating the GIF'
gimp --no-interface --no-data --no-fonts --batch-interpreter=python-fu-eval -b "pdb.python_fu_create_gif('/tmp/out', '/tmp/final.gif', '$scaling')" -b "pdb.gimp_quit(1)"

cp /tmp/final.gif /tmp/write/$output

