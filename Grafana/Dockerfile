FROM ubuntu:trusty
MAINTAINER mlchen@mlchen.org

RUN apt-get update -qq && apt-get install -y \
    curl \
    apt-transport-https

RUN echo deb https://packagecloud.io/grafana/stable/debian/ wheezy main >> /etc/apt/sources.list
RUN curl https://packagecloud.io/gpg.key | apt-key add -

RUN apt-get update -qq && apt-get install -y \
    libfontconfig \
    ca-certificates \
    grafana \
    vim \
    less \
    git \
    wget \
    unzip \
    apt-utils

RUN apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/cache/* && \
    rm -rf /var/lib/log/*

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN grafana-cli plugins install raintank-worldping-app && \
    grafana-cli plugins install grafana-example-app && \
    grafana-cli plugins install grafana-clock-panel && \
    grafana-cli plugins install grafana-piechart-panel && \
    grafana-cli plugins install grafana-influxdb-08-datasource && \
    grafana-cli plugins install grafana-simple-json-datasource && \
    grafana-cli plugins install grafana-worldmap-panel

RUN mkdir -p /var/lib/grafana/plugins
COPY config/grafana.ini /etc/grafana/grafana.ini
RUN mkdir -p /usr/share/grafana/.aws/

RUN chown -R grafana:grafana /etc/grafana /var/lib/grafana /var/lib/grafana/plugins

COPY entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

CMD ["/tmp/entrypoint.sh"]
