#FROM localreg:5000/diamondbase:14.04
FROM localreg:5000/diamond-java8:14.04
MAINTAINER "zhangjun <ibmzhangjun@icloud.com>"

RUN mkdir -p /data
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root
ENV MYAPPNAME myapp

#Change hosts refresh to 10 minutes
RUN rm /usr/bin/confd-start.sh
COPY confd-start.sh /usr/bin/confd-start.sh
RUN chmod 755 /usr/bin/confd-start.sh

#Add sources
RUN mkdir -p /sources
COPY sources/* /sources/
#RUN	/sources/source-change-to-local

#Upgraded ubuntu & Install ansible
RUN apt-get update && apt-get install --no-install-recommends -y git curl zip unzip software-properties-common ca-certificates wget openssh-server apt-transport-https vim nano && \
	  apt-add-repository -y ppa:ansible/ansible && \
	  apt-get update && \
	  apt-get install -y ansible &&\
	  apt-get clean

ENV JENKINS_HOME /var/jenkins_home
ENV JENKINS_SLAVE_AGENT_PORT 50000

# Jenkins home directory is a volume, so configuration and build history 
# can be persisted and survive image upgrades
RUN mkdir -p /var/jenkins_home

# `/usr/share/jenkins/ref/` contains all reference configuration we want 
# to set on a fresh new installation. Use it to bundle additional plugins 
# or config file with your custom jenkins Docker image.
RUN mkdir -p /usr/share/jenkins/ref/init.groovy.d

COPY tini-static /bin/tini
COPY jenkins/init.groovy /usr/share/jenkins/ref/init.groovy.d/tcp-slave-agent-port.groovy

COPY jenkins-war-2.7.1.war /usr/share/jenkins/jenkins.war
ENV JENKINS_UC https://updates.jenkins.io
ENV COPY_REFERENCE_FILE_LOG $JENKINS_HOME/copy_reference_file.log


## ADD start script
# you need to select what you want and uncommon the lines below
##
#If you want to start as a service, the app will not be killed forever

#RUN mkdir /etc/service/$MYAPPNAME
#ADD svsstart.sh /etc/service/$MYAPPNAME/run

#If Just start at boot
ADD svsstart.sh /etc/my_init.d/$MYAPPNAME.sh

WORKDIR /var/jenkins_home

#Clean
RUN apt-get purge -y --auto-remove
RUN rm -rf /var/lib/apt/lists/*

#END
EXPOSE 22 8080 50000
VOLUME ["/data", "/var/jenkins_home"]

COPY jenkins/jenkins.sh /usr/local/bin/jenkins.sh
COPY jenkins/jenkins-support /usr/local/bin/jenkins-support
COPY jenkins/plugins.sh /usr/local/bin/plugins.sh
COPY jenkins/install-plugins.sh /usr/local/bin/install-plugins.sh

CMD ["/sbin/my_init"]
