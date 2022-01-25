# tesseract_dockerfile

I wanted to do some OCR on files from my iphone stored in heic format -- you need to compile imagemagick from scratch to support heic. I also wanted to use tesseract 5 which you also need to compile. This dockerfile does both and prints the OCR on the commandline. PRs welcome to make it nicer

```bash
sudo docker build . -t tesseract
sudo docker run -v /home/m/Downloads:/img tesseract
```
