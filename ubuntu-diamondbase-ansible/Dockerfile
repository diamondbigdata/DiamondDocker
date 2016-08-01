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

## ADD start script
# you need to select what you want and uncommon the lines below
##
#If you want to start as a service, the app will not be killed forever

#RUN mkdir /etc/service/$MYAPPNAME
#ADD svsstart.sh /etc/service/$MYAPPNAME/run

#If Just start at boot
#ADD svsstart.sh /etc/my_init.d/$MYAPPNAME.sh

WORKDIR /data

#Clean
RUN apt-get purge -y --auto-remove
RUN rm -rf /var/lib/apt/lists/*

#END
EXPOSE 22 
VOLUME ["/data"]

CMD ["/sbin/my_init"]
