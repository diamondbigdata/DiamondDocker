#!/bin/bash
if [[ ! -a /etc/ambari-server/conf/password.dat ]]; then
	echo "Ambari Server Setup ..."
	/usr/sbin/ambari-server setup -s
	sleep 5
fi
nohup /usr/sbin/ambari-server start > /tmp/ambari-server-start.log 2>&1 &
sleep 5

#check port 8080
netstat -an | grep 8080
    while [ $? -ne 0 ]
    do
        echo "Ambari server not start ... wait for 2s and check again..."
        sleep 2
        netstat -an | grep 8080
    done
    echo "Ambari server started, pls access the web ui via port 8080 or loadblancer !"

sleep 1
/sources/initrepo.sh