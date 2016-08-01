FROM localreg:5000/ambari-server:2.2.2.0
MAINTAINER "zhangjun <ibmzhangjun@icloud.com>"

#Add Ambari source
RUN rm /etc/apt/sources.list.d/ambari.list && rm /etc/apt/sources.list.d/HDP.list && rm /etc/apt/sources.list.d/HDP-UTILS.list
ADD ambari.list /etc/apt/sources.list.d
ADD HDP.list /etc/apt/sources.list.d
ADD HDP-UTILS.list /etc/apt/sources.list.d

CMD ["/sbin/my_init"]
