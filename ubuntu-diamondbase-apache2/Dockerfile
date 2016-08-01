FROM localreg:5000/diamondbase:14.04
MAINTAINER "zhangjun <ibmzhangjun@icloud.com>"

RUN mkdir -p /data
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /data

#Upgrade ubuntu & Install apache
RUN apt-get -q update && apt-get install -qy apache2 && apt-get clean
RUN mkdir /etc/service/apache
ADD apachestart.sh /etc/service/apache/run

##If Just start at boot
#ADD apachestart.sh /etc/my_init.d/apachestart.sh

#Clean
RUN apt-get purge -y --auto-remove
RUN rm -rf /var/lib/apt/lists/*

EXPOSE 80 443
VOLUME ["/data", "/var/www/html", "/var/log/apache2", "/etc/apache2"]

CMD ["/sbin/my_init"]
