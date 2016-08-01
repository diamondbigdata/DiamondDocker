FROM localreg:5000/diamondbase:14.04
#FROM localreg:5000/diamond-java8:14.04
MAINTAINER "zhangjun <ibmzhangjun@icloud.com>"

RUN mkdir -p /data
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /data
ENV MYAPPNAME ambari
#Ambari ENV
ENV AMBARI_ROLE Node
ENV AMBARI_REPO Ambari/repo  
ENV AMBARI_SERVER Ambari/abserver
ENV AMBARI_NODE Ambari/abnode1
ENV UBUNTU_REPO_HOST_NAME ubuntulocalmirror
ENV USE_UBUNTU_LOCAL_REPO true


#Add Ambari source
ADD ambari.list /etc/apt/sources.list.d
ADD HDP.list /etc/apt/sources.list.d
ADD HDP-UTILS.list /etc/apt/sources.list.d
RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD
RUN apt-get update && apt-get -qy upgrade && apt-get install -qy openssh-server ntp && apt-get clean

#Change hosts refresh to 10 minutes
RUN rm /usr/bin/confd-start.sh
COPY confd-start.sh /usr/bin/confd-start.sh
RUN chmod 755 /usr/bin/confd-start.sh

#Add sources
RUN mkdir -p /sources
COPY sources/* /sources/
#RUN	/sources/source-change-to-local

#Upgraded ubuntu & Install you app here
#RUN apt-get update && apt-get install -qy apache2 && apt-get clean




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

#Clean
RUN apt-get purge -y --auto-remove
RUN rm -rf /var/lib/apt/lists/*

#END
EXPOSE 22
VOLUME ["/data"]

CMD ["/sbin/my_init"]
