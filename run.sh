#!/bin/bash
#export PATH="$PATH:/usr/local/bin"
ls -ltrah /img
mogrify -format jpg /img/*.HEIC
mogrify -format jpg /img/*.png
ls -ltrah /img
tesseract --version
tesseract --help
for file in /img/*.jpg
do 
  echo "---$file BEGIN---"
  tesseract "$file" stdout -l eng --oem 1 --psm 6 txt
  mv 
  echo "---$file END---"
done

