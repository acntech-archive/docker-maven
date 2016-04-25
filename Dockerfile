FROM acntech/jdk:1.8.0_92


RUN apt-get -y update
RUN wget --no-cookies --no-check-certificate "http://apache.uib.no/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz" -O /tmp/maven.tar.gz
RUN mkdir /opt/maven && tar -xzvf /tmp/maven.tar.gz -C /opt/maven/ && ln -s /opt/maven/apache-maven-3.3.9/ /opt/maven/default && rm -f /tmp/maven.tar.gz


ENV MAVEN_HOME /opt/maven/default
ENV M2_HOME $MAVEN_HOME
ENV PATH $PATH:$MAVEN_HOME/bin


#CMD ["mvn -version"]
CMD ["/bin/bash"]