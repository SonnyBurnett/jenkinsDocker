FROM jenkins/jenkins:lts
# if we want to install via apt
USER root
RUN apt-get update && apt-get install -y
RUN wget https://apache.newfountain.nl/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz 
RUN tar zxf apache-maven-3.6.3-bin.tar.gz --directory=/opt
RUN ln -s /opt/apache-maven-3.6.3 /opt/maven
RUN ln -s /opt/maven/bin/mvn /usr/bin/mvn
ENV M2_HOME /opt/maven
RUN echo "export M2_HOME=/opt/maven" >> /etc/bashrc 
RUN apt-get -y install git

RUN mkdir -p /var/deploy_data

# drop back to the regular jenkins user - good practice
USER jenkins
LABEL name="CI Jenkins container"

