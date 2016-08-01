FROM localreg:5000/node:6.3
MAINTAINER "zhangjun <ibmzhangjun@icloud.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /data
ENV MYAPPNAME rediscommander

ENV TERM=xterm-color
# Install node packages.
RUN npm install -g redis-commander

## ADD start script
# you need to select what you want and uncommon the lines below
##
#If you want to start as a service, the app will not be killed forever

#RUN mkdir /etc/service/$MYAPPNAME
#ADD svsstart.sh /etc/service/$MYAPPNAME/run

#If Just start at boot
ADD svsstart.sh /etc/my_init.d/$MYAPPNAME.sh

#Clean
RUN apt-get purge -y --auto-remove
RUN rm -rf /var/lib/apt/lists/*

#END
EXPOSE 8081

CMD ["/sbin/my_init"]
