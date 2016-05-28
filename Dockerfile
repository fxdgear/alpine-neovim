FROM alpine:latest
MAINTAINER Nick Lang <nick@nicklang.com>

RUN apk add --update git alpine-sdk libtool cmake automake m4 autoconf linux-headers unzip ncurses-dev python py-pip && rm -rf /var/cache/apk/*

WORKDIR /tmp
ENV CMAKE_EXTRA_FLAGS=-DENABLE_JEMALLOC=OFF

RUN git clone https://github.com/neovim/libtermkey.git && \
  cd libtermkey && \
  make && \
  make install && \
  cd ../ && rm -rf libtermkey

RUN git clone https://github.com/neovim/libvterm.git && \
  cd libvterm && \
  make && \
  make install && \
  cd ../ && rm -rf libvterm

RUN git clone https://github.com/neovim/unibilium.git && \
  cd unibilium && \
  make && \
  make install && \
  cd ../ && rm -rf unibilium

RUN  git clone https://github.com/neovim/neovim.git && \
  cd neovim && \
  make && \
  make install && \
  cd ../ && rm -rf nvim

CMD /usr/local/bin/nvim 
