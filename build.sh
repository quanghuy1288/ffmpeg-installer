
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
export PATH=$PATH:/usr/local/bin

cp -r fonts/ /usr/share/fonts
tar -xvf ffmpeg.2.8.13.taz.gz -C /

git clone https://github.com/quanghuy1288/gpac.git /opt/gpac

cd /opt/gpac && ./configure --disable-wx --strip --prefix=/usr/local && make && make install && make clean

ffmpeg