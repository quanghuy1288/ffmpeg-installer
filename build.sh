
yum -y localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-6.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-6.noarch.rpm

yum -y install git tar curl wget which  bison gcc gcc-c++ \
 automake autoconf libtool \
 gnutls-devel \
 opencore-amr opencore-amr-devel \
 openjpeg openjpeg-devel \
 pulseaudio-libs-devel \
 librtmp-devel \
 schroedinger-devel \
 speex-devel \
 libtheora-devel \
 libvorbis-devel \
 xvidcore-devel \
 openal-soft-devel \
 libavc1394-devel libdc1394-devel \
 libcdio-devel \
 libX11-devel \
 freetype-devel \
 fontconfig-devel \
 libpng libpng-devel \
 libXfixes-devel libXext-devel cmake && yum clean all

export LD_LIBRARY_PATH=/usr/local/lib/:/usr/local/lib64/:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig/

cp fonts/ /usr/share/fonts

git clone https://github.com/quanghuy1288/fribidi.git /opt/fribidi \
  && git clone https://github.com/libass/libass.git /opt/libass  \
  && git clone https://github.com/rbrito/lame.git /opt/lame \
  && git clone git://github.com/yasm/yasm.git /opt/yasm \
  && git clone git://git.videolan.org/x264.git /opt/x264 \
  && git clone https://github.com/videolan/x265.git /opt/x265 \
  && git clone git://source.ffmpeg.org/ffmpeg.git /opt/ffmpeg \
  && git clone https://github.com/quanghuy1288/gpac.git /opt/gpac \
  && git clone https://github.com/quanghuy1288/libfaac.git /opt/libfaac

cd /opt/fribidi && git checkout 0.19.7 \
 && cd /opt/libass && git checkout 0.13.0 \
 && cd /opt/libfaac && git checkout 1.28 \
 && cd /opt/lame && git checkout  RELEASE__3_99_5 \
 && cd /opt/yasm && git checkout v1.3.0 \
 && cd /opt/x265 && git checkout 1.9 \
 && cd /opt/ffmpeg && git checkout n2.8.13 \
 && cd /opt/gpac && git checkout 0.4.5 \
 &&  cd /opt/x264 && git checkout 3f5ed56d4105f68c01b86f94f41bb9bbefa3433b

cd /opt && wget -O fdk-aac.tar.gz https://github.com/mstorsjo/fdk-aac/tarball/master && tar xzvf fdk-aac.tar.gz \
 && cd /opt/mstorsjo-fdk-aac* && autoreconf -fiv && ./configure --prefix=/usr/local && make && make install \
 && cd /opt/fribidi && ./configure   --prefix=/usr/local && make && make install && ldconfig && make clean \
 && cd /opt/libass && ./autogen.sh && ./configure   --prefix=/usr/local && make && make install && ldconfig && make clean \
 && cd /opt/libfaac && ./bootstrap && ./configure --prefix=/usr/local && sed -i -e "s|^char \*strcasestr.*|//\0|" common/mp4v2/mpeg4ip.h \
 && cd /opt/libfaac &&  make && make install && ldconfig && make clean \
 && cd /opt/lame && ./configure --prefix=/usr/local &&  make && make install && ldconfig && make clean \
 && cd /opt/yasm/ && ./autogen.sh && ./configure --prefix=/usr/local  && make && make install && ldconfig && make clean \
 && cd /opt/x264 && ./configure --prefix=/usr/local --enable-shared && make && make install && ldconfig && make clean \
 && cd /opt/x265/build && cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="/usr/local" -DENABLE_SHARED:bool=on ../source && make && make install && ldconfig && make clean

cd /opt/ffmpeg && ./configure --prefix=/usr/local \
  --arch=x86_64 \
  --extra-cflags='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic' \
  --enable-bzlib \
  --enable-zlib \
  --disable-ffserver \
  --disable-ffplay \
  --disable-doc \
  --disable-crystalhd \
  --enable-gnutls \
  --enable-libass \
  --enable-libcdio \
  --enable-libdc1394 \
  --disable-indev=jack \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-openal \
  --enable-libopenjpeg \
  --enable-libpulse \
  --enable-librtmp \
  --enable-libschroedinger \
  --enable-libspeex \
  --enable-libtheora \
  --enable-libvorbis \
  --enable-libx264 \
  --enable-libxvid \
  --enable-x11grab \
  --enable-avfilter \
  --enable-postproc \
  --enable-pthreads \
  --disable-static \
  --enable-shared \
  --enable-gpl \
  --disable-debug \
  --disable-stripping \
  --enable-runtime-cpudetect \
  --enable-swscale \
  --enable-swresample \
  --enable-libopencore-amrwb \
  --enable-libopencore-amrnb \
  --enable-libfaac  \
  --enable-nonfree \
  --enable-version3 \
  --enable-gray \
  --yasmexe=/usr/local/bin/yasm \
  --enable-yasm \
  --enable-libx265 --enable-libfdk-aac && make && make install && make clean \
 && cd /opt/gpac && ./configure --disable-wx --strip --prefix=/usr/local && make && make install && make clean


