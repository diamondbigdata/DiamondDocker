FROM localreg:5000/ambari-server:2.2.2.0
MAINTAINER "zhangjun <ibmzhangjun@icloud.com>"

#Add patch
ADD refreshconfd.sh /usr/bin/refreshconfd.sh
RUN chmod +x /usr/bin/refreshconfd.sh

CMD ["/sbin/my_init"]
