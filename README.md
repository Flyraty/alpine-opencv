# alpine-opencv

## Background
  Installing opencv use pip or other .whl in alpine image is difficult. I found  this [issue](https://github.com/skvark/opencv-python/issues/75). Because Alpine Linux is based on musl libc and not on GNU libc and thus it's not a GNU/Linux distribution. Manylinux supports only GNU/Linux. Pip and other python packaging tools do not provide tools to build or distribute binary packages for musl based Linux distributions.  
    
  I used one day to solve this problem. So i decided to record it. docker build will spend your much time. so you can pull this image directly.
  
## USE

``
docker pull flyraty/alpine-opencv
``
