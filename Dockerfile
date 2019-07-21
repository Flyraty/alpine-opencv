FROM alpine:3.6

ENV OPENCV https://github.com/opencv/opencv/archive/3.4.6.tar.gz
ENV OPENCV_VER 3.4.6

RUN apk add -U --no-cache --virtual=build-dependencies \
    linux-headers musl libxml2-dev libxslt-dev libffi-dev g++ \
    musl-dev libgcc openssl-dev jpeg-dev zlib-dev freetype-dev build-base \
    lcms2-dev openjpeg-dev python3-dev make cmake clang clang-dev ninja \
    && apk add --no-cache gcc zlib jpeg libjpeg freetype openjpeg curl python3 tiff\
    && curl https://bootstrap.pypa.io/get-pip.py | python3 \
    && ln -s /usr/include/locale.h /usr/include/xlocale.h \
    && pip3 install -U --no-cache-dir Pillow numpy

RUN mkdir /opt && cd /opt && \
    curl -L $OPENCV | tar zx && \
    cd opencv-$OPENCV_VER && \
    mkdir build && cd build && \
    cmake -G Ninja \
          -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D WITH_FFMPEG=NO \
          -D WITH_IPP=NO \
          -D PYTHON_EXECUTABLE=/usr/bin/python3 \
          -D WITH_OPENEXR=NO .. && \
    ninja && ninja install && \
    cp -p $(find /usr/local/lib/python3.6/site-packages -name cv2.*.so) \
    /usr/lib/python3.6/site-packages/cv2.so && \
    apk del build-dependencies && \
    rm -rf /var/cexitache/apk/*

RUN python3 -c 'import cv2; print("Python: import cv2 - SUCCESS")'