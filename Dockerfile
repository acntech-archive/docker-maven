FROM acntechie/jdk:latest
MAINTAINER Thomas Johansen "thomas.johansen@accenture.com"


ARG MAVEN_URL=https://www.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
ARG MAVEN_DIR=apache-maven-3.3.9


RUN apt-get update && \
    apt-get -y upgrade && \
    rm -rf /var/lib/apt/lists/*

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

RUN update-alternatives --install "/usr/bin/mvn" "mvn" "/opt/maven/default/bin/mvn" 1 && \
    update-alternatives --set "mvn" "/opt/maven/default/bin/mvn"


ENV MAVEN_HOME /opt/maven/default
ENV M2_HOME $MAVEN_HOME
ENV PATH $PATH:$MAVEN_HOME/bin


CMD ["/bin/bash"]