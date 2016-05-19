FROM acntech/jdk:1.8.0_92


RUN apt-get -y update
RUN wget --no-cookies --no-check-certificate "https://www.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz" -O /tmp/maven.tar.gz
RUN wget --no-cookies --no-check-certificate "https://www.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz.asc" -O /tmp/maven.tar.gz.asc
RUN wget --no-cookies --no-check-certificate "https://www.apache.org/dist/maven/KEYS" -O /tmp/maven.KEYS
RUN gpg --import /tmp/maven.KEYS && gpg --verify /tmp/maven.tar.gz.asc /tmp/maven.tar.gz
RUN mkdir /opt/maven && tar -xzvf /tmp/maven.tar.gz -C /opt/maven/ && ln -s /opt/maven/apache-maven-3.3.9/ /opt/maven/default && rm -f /tmp/maven.*
RUN update-alternatives --install "/usr/bin/mvn" "mvn" "/opt/maven/default/bin/mvn" 1 && update-alternatives --set "mvn" "/opt/maven/default/bin/mvn"


ENV MAVEN_HOME /opt/maven/default
ENV M2_HOME $MAVEN_HOME
ENV PATH $PATH:$MAVEN_HOME/bin


#CMD ["mvn -version"]
CMD ["/bin/bash"]