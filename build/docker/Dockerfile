# Build environment for GePhex (matches Debian 13 "trixie").
FROM debian:trixie
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      build-essential autoconf automake libtool pkg-config nasm python3 ca-certificates \
      qtbase5-dev qtbase5-dev-tools \
      libsdl1.2-compat-dev libsdl-image1.2-dev libsdl-ttf2.0-dev \
      libavcodec-dev libavformat-dev libavutil-dev libswscale-dev \
      libasound2-dev libgl-dev libglu1-mesa-dev libpng-dev libaa1-dev \
      libx11-dev libxext-dev libxv-dev linux-libc-dev \
      xvfb xauth x11-utils x11-apps xdotool imagemagick ffmpeg fonts-dejavu-core gdb valgrind \
    && rm -rf /var/lib/apt/lists/*
