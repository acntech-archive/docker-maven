FROM acntechie/jdk:latest-alpine
MAINTAINER Thomas Johansen "thomas.johansen@accenture.com"


ARG MAVEN_VERSION=3.5.0
ARG MAVEN_URL=https://www.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
ARG MAVEN_DIR=apache-maven-${MAVEN_VERSION}


RUN apk update && \
    apk upgrade && \
    rm -rf /var/cache/apk/*

RUN wget --no-cookies --no-check-certificate "${MAVEN_URL}" -O /tmp/maven.tar.gz
RUN wget --no-cookies --no-check-certificate "${MAVEN_URL}.asc" -O /tmp/maven.tar.gz.asc
RUN wget --no-cookies --no-check-certificate "https://www.apache.org/dist/maven/KEYS" -O /tmp/maven.KEYS

RUN gpg --import /tmp/maven.KEYS && \
    gpg --verify /tmp/maven.tar.gz.asc /tmp/maven.tar.gz

RUN mkdir /opt/maven && \
    tar -xzvf /tmp/maven.tar.gz -C /opt/maven/ && \
    cd /opt/maven && \
    ln -s ${MAVEN_DIR}/ default && \
    rm -f /tmp/maven.*


ENV MAVEN_HOME /opt/maven/default
ENV M2_HOME ${MAVEN_HOME}
ENV PATH ${PATH}:${MAVEN_HOME}/bin


CMD ["mvn", "-version"]
