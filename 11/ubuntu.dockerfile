FROM ubuntu:22.04

ENV JAVA_VERSION jre-11.0.20.17+8

RUN apt-get update && apt-get install -y curl && \
    cd /tmp && \
    curl -LfsSo /tmp/openjdk.tar.gz \
        https://github.com/dragonwell-project/dragonwell11/releases/download/dragonwell-extended-11.0.20.17_jdk-11.0.20-ga/Alibaba_Dragonwell_Extended_11.0.20.17.8_x64_linux.tar.gz \
    && \
    mkdir -p /tmp/openjdk && cd /tmp/openjdk && \
    tar -zxf /tmp/openjdk.tar.gz --strip-components=1 && \
    /tmp/openjdk/bin/jlink \
        --module-path /tmp/openjdk/jmods \
        --add-modules ALL-MODULE-PATH \
        --compress=1 \
        --output /opt/java/jre \
    && \
    rm -rf /tmp/openjdk.tar.gz && rm -rf /tmp/openjdk && \
    apt-get purge -y curl && apt-get autoremove -y && apt-get clean

ENV JAVA_HOME=/opt/java/openjdk \
    PATH="/opt/java/jre/bin:$PATH"
