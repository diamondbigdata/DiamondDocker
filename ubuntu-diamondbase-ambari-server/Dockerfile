FROM localreg:5000/ambari-base:2.2.2.0
MAINTAINER "zhangjun <ibmzhangjun@icloud.com>"

RUN mkdir -p /data
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /data
ENV MYAPPNAME ambari-server
#Ambari ENV
ENV AMBARI_ROLE Server
ENV AMBARI_REPO Ambari/repo  
ENV AMBARI_SERVER Ambari/abserver
ENV AMBARI_NODE Ambari/abnode1
ENV UBUNTU_REPO_HOST_NAME ubuntulocalmirror
ENV USE_UBUNTU_LOCAL_REPO true


#Install Ambari node
RUN apt-get update
ADD ambariinst.tar /var/cache/apt/archives/
RUN apt-get install -qy mysql-connector-java ambari-server && apt-get clean

## ADD start script
# you need to select what you want and uncommon the lines below
##
#If you want to start as a service, the app will not be killed forever

#RUN mkdir /etc/service/$MYAPPNAME
#ADD svsstart.sh /etc/service/$MYAPPNAME/run

#If Just start at boot
ADD svsstart.sh /etc/my_init.d/$MYAPPNAME.sh

# Copy the Site files up
# Add confd tmpl and toml
ADD confd/*.toml /etc/confd/conf.d/
ADD confd/*.tmpl /etc/confd/templates/

# Add monit conf for services
ADD monit/*.conf /etc/monit/conf.d/

#ambari-setup
COPY jdk-8u60-linux-x64.tar.gz /var/lib/ambari-server/resources/
COPY jce_policy-8.zip /var/lib/ambari-server/resources/

#Add start script
ADD startabserver.sh /usr/bin/startabserver.sh
RUN chmod +x /usr/bin/startabserver.sh

#Clean
RUN apt-get purge -y --auto-remove
RUN rm -rf /var/lib/apt/lists/*

#END
EXPOSE 22
VOLUME ["/data"]

CMD ["/sbin/my_init"]
