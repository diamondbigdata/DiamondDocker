FROM localreg:6000/diamondbase:14.04
#FROM localreg:5000/diamond-java8:14.04
MAINTAINER "zhangjun <ibmzhangjun@icloud.com>"

RUN mkdir -p /data
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /data
ENV MYAPPNAME dockerregistry

#Change hosts refresh to 10 minutes
RUN rm /usr/bin/confd-start.sh
COPY confd-start.sh /usr/bin/confd-start.sh
RUN chmod 755 /usr/bin/confd-start.sh

#Add sources
RUN mkdir -p /sources
COPY sources/* /sources/
#RUN	/sources/source-change-to-local

#Upgraded ubuntu & Install you app here
RUN apt-get update && apt-get install -qy apache2 ca-certificates apache2-utils musl-tools && apt-get clean

COPY ./distribution-library-image/registry/registry /bin/registry
COPY ./distribution-library-image/registry/config-example.yml /etc/docker/registry/config.yml
RUN mkdir -p /certs
COPY ./certs/* /certs/
RUN mkdir -p /usr/local/share/ca-certificates
COPY ./certs/domain.crt /usr/local/share/ca-certificates
RUN update-ca-certificates



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
EXPOSE 22 5000
VOLUME ["/data", "/var/lib/registry"]

CMD ["/sbin/my_init"]
