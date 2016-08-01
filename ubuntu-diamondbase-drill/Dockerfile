#FROM localreg:5000/diamondbase:14.04
FROM localreg:5000/diamond-java8:14.04
MAINTAINER "zhangjun <ibmzhangjun@icloud.com>"

RUN mkdir -p /data
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /data
ENV MYAPPNAME drill

#Change hosts refresh to 10 minutes
RUN rm /usr/bin/confd-start.sh
COPY confd-start.sh /usr/bin/confd-start.sh
RUN chmod 755 /usr/bin/confd-start.sh

#Add sources
RUN mkdir -p /sources
COPY sources/* /sources/
#RUN	/sources/source-change-to-local

#Upgraded ubuntu & Install you app here
#RUN apt-get update && apt-get install -qy nmon && apt-get clean

# Set environment
ENV DRILL_VERSION=1.7.0 \
    DRILL_HOME=/opt/drill \ 
    DRILL_LOG_DIR=/opt/drill/logs \
    PATH=/opt/drill/bin:${PATH}
ENV DRILL_RELEASE=apache-drill-${DRILL_VERSION}a
ENV DRILL_CLUSTER=drillCluster
ENV DRILL_HEAP=4G
ENV DRILL_MAX_DIRECT_MEMORY=8G
ENV ZK_SERVICE=Kafka/zk
ADD apache-drill-1.7.0.tar /opt
RUN mv /opt/apache-drill-1.7.0 ${DRILL_HOME} \
  && mkdir -p ${DRILL_LOG_DIR} ${DRILL_HOME}/data \
  && chmod +x ${DRILL_HOME}/bin/drillbit.sh

# Add confd tmpl and toml
ADD confd/*.toml /etc/confd/conf.d/
ADD confd/*.tmpl /etc/confd/templates/

# Add monit conf for services
ADD monit/*.conf /etc/monit/conf.d/

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

WORKDIR $DRILL_HOME
#END
EXPOSE 22 8047
VOLUME ["/opt/drill/data"]

CMD ["/sbin/my_init"]
