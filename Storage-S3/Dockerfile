FROM ubuntu:trusty
MAINTAINER mlchen@mlchen.org

RUN apt-get update -qq && apt-get install -y \
	automake \
	autotools-dev \
	g++ \
	libcurl4-gnutls-dev \
	libfuse-dev \
	libssl-dev \
	libxml2-dev \
	make \
	pkg-config

RUN apt-get update -qq && apt-get install -y \
    vim \
    less \
    curl \
    git \
    wget \
    unzip \
    locales \
    apt-utils

RUN apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/cache/* && \
    rm -rf /var/lib/log/*

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN wget https://github.com/s3fs-fuse/s3fs-fuse/archive/master.zip
RUN unzip master.zip
RUN cd s3fs-fuse-master && ./autogen.sh && ./configure && make && make install

RUN mkdir /storage

WORKDIR /storage
VOLUME /storage

COPY entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

CMD ["/tmp/entrypoint.sh"]
