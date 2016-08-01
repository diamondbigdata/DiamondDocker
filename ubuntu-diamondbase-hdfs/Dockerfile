#FROM localreg:5000/diamondbase:14.04
FROM localreg:5000/diamond-java8:14.04
MAINTAINER "zhangjun <ibmzhangjun@icloud.com>"

RUN mkdir -p /data
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /data
ENV MYAPPNAME myapp

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

# Setup env
USER root
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

ENV HADOOP_PREFIX /opt/hadoop
ENV HADOOP_COMMON_HOME /opt/hadoop
ENV HADOOP_CONF_DIR /opt/hadoop/etc/hadoop

ENV HDPRole jnode
ENV HDPClusterName DiamondHDP
ENV HDP_START_TIMEWAIT 10
ENV ZK_SERVICE Kafka/zk
ENV PNode_SERVICE HDP/pnode
ENV SNode_SERVICE HDP/snode
ENV JNode_SERVICE HDP/jnode
ENV PNode_SERVICE_HostName PNameNode
ENV SNode_SERVICE_HostName SNameNode
ENV HADOOP_HDFS_NAMENODE /data/hdfs/namenode
ENV HADOOP_HDFS_JOURNALNODE /data/hdfs/journal
ENV HADOOP_HDFS_DATANODE /data/hdfs/datanode 



## ADD start script
# you need to select what you want and uncommon the lines below
##
#If you want to start as a service, the app will not be killed forever

#RUN mkdir /etc/service/$MYAPPNAME
#ADD svsstart.sh /etc/service/$MYAPPNAME/run

#If Just start at boot
#ADD svsstart.sh /etc/my_init.d/$MYAPPNAME.sh

#Clean
RUN apt-get purge -y --auto-remove
RUN rm -rf /var/lib/apt/lists/*

#END
EXPOSE 22
VOLUME ["/data"]

CMD ["/sbin/my_init"]
