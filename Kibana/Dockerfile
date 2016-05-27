FROM kibana:4.1.6
MAINTAINER mlchen@mlchen.org
# 這裡採用舊版 4.1.6 是因為 AWS ES 的版本比較舊，並無法跟最新版 Kibana 相容。

RUN apt-get update -qq && apt-get install -y \
    vim \
    less \
    curl \
    git \
    wget \
    unzip \
    apt-utils \
    locales

RUN apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/cache/* && \
    rm -rf /var/lib/log/*

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# RUN kibana plugin --install elastic/sense
# 舊版 Kibana 不支援這外掛

COPY config/kibana.yml /opt/kibana/config/kibana.yml

COPY entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

CMD ["/tmp/entrypoint.sh"]
