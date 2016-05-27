FROM logstash:latest
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
    apt-utils \
    locales \
    python-setuptools \
    python-pip

RUN apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/cache/* && \
    rm -rf /var/lib/log/*

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN /opt/logstash/bin/plugin install logstash-output-amazon_es
# 安裝 logstash to AWS ES 的 plugin

COPY config/*.conf /etc/logstash/conf.d/
RUN	mkdir -p /opt/logstash/vendor/geoip
COPY files/GeoLiteCity.dat /opt/logstash/vendor/geoip/GeoLiteCity.dat
COPY files/template.json /tmp/template.json
RUN chown -R logstash:logstash /opt/logstash/*
# 處理 logstash 設定檔

RUN wget https://github.com/s3fs-fuse/s3fs-fuse/archive/master.zip
RUN unzip master.zip
RUN cd s3fs-fuse-master && ./autogen.sh && ./configure && make && make install
RUN mkdir /storage
# 處理 Persist Data 方法，mount S3 bucket 當共享網路儲存空間。

RUN pip install elasticsearch-curator

COPY files/logstash.sh /tmp/logstash.sh
RUN chmod +x /tmp/logstash.sh

RUN pip install supervisor
COPY supervisord.conf /usr/local/etc/supervisord.conf

CMD ["/usr/local/bin/supervisord"]
