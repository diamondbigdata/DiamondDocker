#FROM localreg:5000/diamondbase:14.04
FROM localreg:5000/diamond-java8:14.04
MAINTAINER "zhangjun <ibmzhangjun@icloud.com>"

RUN mkdir -p /data
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /data
ENV MYAPPNAME spark

#Change hosts refresh to 10 minutes
RUN rm /usr/bin/confd-start.sh
COPY confd-start.sh /usr/bin/confd-start.sh
RUN chmod 755 /usr/bin/confd-start.sh

#Add sources
RUN mkdir -p /sources
COPY sources/* /sources/
#RUN	/sources/source-change-to-local

#Upgraded ubuntu & Install you app here
RUN apt-get update && apt-get install -qy unzip && apt-get clean

# Set environment
ENV SPARK_VERSION=1.6.2 \
    HADOOP_VERSION=2.6 \
    SPARK_HOME=/opt/spark \
    SPARK_LOG_DIR=/opt/spark/logs \
    SCALA_VERSION=2.10.6 \
    PATH=/usr/lib/scala/scala-2.10.6/bin:/opt/spark/bin:${PATH}
ENV SPARK_RELEASE=spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}

#for start.sh & slaves SPARK_ROLE=master|worker
ENV SPARK_ROLE=master
ENV SPARK_IP=sparkmaster
ENV SPARK_WORKER_HOSTNAME=sparkworker

#for spark-env.sh
ENV SPARK_MASTER_IP=sparkmaster
ENV SPARK_MASTER_PORT=7077
ENV SPARK_MASTER_WEBUI_PORT=8080
ENV SPARK_MASTER_OPTS=""
ENV SPARK_WORKER_CORES=4
ENV SPARK_WORKER_MEMORY=1g
ENV SPARK_WORKER_WEBUI_PORT=8081
ENV SPARK_EXECUTOR_INSTANCES=1
ENV SPARK_WORKER_DIR=/opt/spark/work
ENV SPARK_WORKER_OPTS=""
ENV SPARK_DAEMON_MEMORY=1g
ENV SPARK_HISTORY_OPTS=""
ENV SPARK_SHUFFLE_OPTS=""
ENV SPARK_DAEMON_JAVA_OPTS=""

#for spark-defaults.conf
ENV SPARK_EVENTlOG_ENABLED=false
ENV SPARK_EVENTlOG_DIR=/tmp/sparkeventlog
ENV SPARK_SERIALIZER=org.apache.spark.serializer.KryoSerializer
ENV SPARK_DRIVER_MEMORY=1g
ENV SPARK_EXECUTOR_EXTRAJAVAOPTIONS=""

#add spark & scala
ADD ${SPARK_RELEASE}.tar /opt
RUN ln -s /opt/${SPARK_RELEASE} ${SPARK_HOME} \
  && mkdir -p ${SPARK_LOG_DIR}
  
RUN mkdir -p /usr/lib/scala
ADD scala-2.10.6.tar /usr/lib/scala




## ADD start script
# you need to select what you want and uncommon the lines below
##
#If you want to start as a service, the app will not be killed forever

#RUN mkdir /etc/service/$MYAPPNAME
#ADD svsstart.sh /etc/service/$MYAPPNAME/run

#If Just start at boot
ADD svsstart.sh /etc/my_init.d/$MYAPPNAME.sh

# Add start script
ADD startspark.sh /usr/bin/startspark.sh
RUN chmod +x /usr/bin/startspark.sh

#Clean
RUN apt-get purge -y --auto-remove
RUN rm -rf /var/lib/apt/lists/*

#END

WORKDIR $SPARK_HOME
EXPOSE 8080 7077 6066 8081
VOLUME ["/opt/spark/conf"] 

CMD ["/sbin/my_init"]
