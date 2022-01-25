FROM ubuntu:latest

WORKDIR /usr/src/app

#COPY requirements.txt ./
#RUN pip install --no-cache-dir -r requirements.txt
RUN apt update
RUN apt remove imagemagick -y
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

# install base dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends\
  libde265-dev \
  libdjvulibre-dev \
  libfftw3-dev \
  libghc-bzlib-dev \
  libgoogle-perftools-dev \
  libgraphviz-dev \
  libgs-dev \
  libheif-dev \
  libjbig-dev \
  libjemalloc-dev \
  libjpeg-dev \
  liblcms2-dev \
  liblqr-1-0-dev \
  liblzma-dev \
  libopenexr-dev \
  libpango1.0-dev \
  libraqm-dev \
  libraw-dev \
  libtiff-dev \
  libwebp-dev \
  libwmf-dev \
  libzip-dev \
  libzstd-dev

RUN apt-get install -y git
RUN git clone --depth 1 --branch 7.1.0-19 https://github.com/ImageMagick/ImageMagick.git
RUN apt-get install -y build-essential
RUN cd ImageMagick && ./configure \
	--with-bzlib=yes \
	--with-djvu=yes \
	--with-fftw=yes \
	--with-fontconfig=yes \
	--with-freetype=yes \
	--with-gslib=yes \
	--with-gvc=yes \
	--with-heic=yes \
	--with-jbig=yes \
	--with-jemalloc=yes \
	--with-jpeg=yes \
	--with-lcms=yes \
	--with-lqr=yes \
	--with-lzma=yes \
	--with-magick-plus-plus=yes \
	--with-openexr=yes \
	--with-openjp2=yes \
	--with-pango=yes \
	--with-perl=yes \
	--with-png=yes \
	--with-raqm=yes \
	--with-raw=yes \
	--with-rsvg=yes \
	--with-tcmalloc=yes \
	--with-tiff=yes \
	--with-webp=yes \
	--with-wmf=yes \
	--with-x=yes \
	--with-xml=yes \
	--with-zip=yes \
	--with-zlib=yes \
	--with-zstd=yes

RUN cd ImageMagick && make -j 8
RUN cd ImageMagick && make install
RUN cd ImageMagick && ldconfig /usr/local/lib
RUN cd ImageMagick && identify --version

RUN apt-get install -y libtool libleptonica-dev
RUN git clone --depth 1 --branch 5.0.1 https://github.com/tesseract-ocr/tesseract.git
RUN cd tesseract && ./autogen.sh && ./configure && make -j8 && make install && ldconfig


COPY . .
COPY eng.traineddata /usr/local/share/tessdata/eng.traineddata

CMD [ "/usr/src/app/run.sh" ]
