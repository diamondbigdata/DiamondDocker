#!/bin/sh
#Spart ENV
SPARK_ROLE=${SPARK_ROLE:-"master"} 
SPARK_IP=${SPARK_IP:-"sparkmaster"}
SPARK_WORKER_HOSTNAME=${SPARK_WORKER_HOSTNAME:-"sparkworker"}
SPARK_MASTER_IP=${SPARK_MASTER_IP:-"sparkmaster"} 
SPARK_MASTER_PORT=${SPARK_MASTER_PORT:-"7077"} 
SPARK_MASTER_WEBUI_PORT=${SPARK_MASTER_WEBUI_PORT:-"8080"} 
SPARK_MASTER_OPTS=${SPARK_MASTER_OPTS:-""} 
SPARK_WORKER_CORES=${SPARK_WORKER_CORES:-"4"} 
SPARK_WORKER_MEMORY=${SPARK_WORKER_MEMORY:-"1g"}
SPARK_WORKER_WEBUI_PORT=${SPARK_WORKER_WEBUI_PORT:-"8081"} 
SPARK_EXECUTOR_INSTANCES=${SPARK_EXECUTOR_INSTANCES:-"1"} 
SPARK_WORKER_DIR=${SPARK_WORKER_DIR:-"/opt/spark/work"} 
SPARK_WORKER_OPTS=${SPARK_WORKER_OPTS:-""} 
SPARK_DAEMON_MEMORY=${SPARK_DAEMON_MEMORY:-"1g"} 
SPARK_HISTORY_OPTS=${SPARK_HISTORY_OPTS:-""} 
SPARK_SHUFFLE_OPTS=${SPARK_SHUFFLE_OPTS:-""} 
SPARK_DAEMON_JAVA_OPTS=${SPARK_DAEMON_JAVA_OPTS:-""} 
SPARK_EVENTlOG_ENABLED=${SPARK_EVENTlOG_ENABLED:-"false"} 
SPARK_EVENTlOG_DIR=${SPARK_EVENTlOG_DIR:-"/tmp/sparkeventlog"} 
SPARK_SERIALIZER=${SPARK_SERIALIZER:-"org.apache.spark.serializer.KryoSerializer"} 
SPARK_DRIVER_MEMORY=${SPARK_DRIVER_MEMORY:-"1g"} 
SPARK_EXECUTOR_EXTRAJAVAOPTIONS=${SPARK_EXECUTOR_EXTRAJAVAOPTIONS:-""} 

export SPARK_ROLE SPARK_IP SPARK_WORKER_HOSTNAME SPARK_MASTER_IP SPARK_MASTER_PORT SPARK_MASTER_WEBUI_PORT SPARK_MASTER_OPTS
export SPARK_WORKER_CORES SPARK_WORKER_MEMORY SPARK_WORKER_WEBUI_PORT SPARK_EXECUTOR_INSTANCES SPARK_WORKER_DIR SPARK_WORKER_OPTS
export SPARK_DAEMON_MEMORY SPARK_HISTORY_OPTS SPARK_SHUFFLE_OPTS SPARK_DAEMON_JAVA_OPTS SPARK_EVENTlOG_ENABLED SPARK_EVENTlOG_DIR SPARK_SERIALIZER SPARK_DRIVER_MEMORY SPARK_EXECUTOR_EXTRAJAVAOPTIONS

#Init slaves
SLAVES_FILE=/opt/spark/conf/slaves
echo "" > $SLAVES_FILE
echo "# A Spark Worker will be started on each of the machines listed below." >> $SLAVES_FILE
for i in `echo "$SPARK_WORKER_HOSTNAME" | sed 's/,/\n/g'`
do  
    echo $i >> $SLAVES_FILE
done
cat $SLAVES_FILE

#Init spark-env.sh
ENV_FILE=/opt/spark/conf/spark-env.sh
echo "" > $ENV_FILE
echo "#!/usr/bin/env bash" >> $ENV_FILE
echo "# Options for the daemons used in the standalone deploy mode" >> $ENV_FILE
echo "export SPARK_MASTER_IP=$SPARK_MASTER_IP" >> $ENV_FILE
echo "export SPARK_MASTER_PORT=$SPARK_MASTER_PORT" >> $ENV_FILE
echo "export SPARK_MASTER_WEBUI_PORT=$SPARK_MASTER_WEBUI_PORT" >> $ENV_FILE
echo "export SPARK_MASTER_OPTS=$SPARK_MASTER_OPTS" >> $ENV_FILE
echo "export SPARK_WORKER_CORES=$SPARK_WORKER_CORES" >> $ENV_FILE
echo "export SPARK_WORKER_MEMORY=$SPARK_WORKER_MEMORY" >> $ENV_FILE
echo "export SPARK_WORKER_WEBUI_PORT=$SPARK_WORKER_WEBUI_PORT" >> $ENV_FILE
echo "export SPARK_EXECUTOR_INSTANCES=$SPARK_EXECUTOR_INSTANCES" >> $ENV_FILE
echo "export SPARK_WORKER_DIR=$SPARK_WORKER_DIR" >> $ENV_FILE
echo "export SPARK_WORKER_OPTS=$SPARK_WORKER_OPTS" >> $ENV_FILE
echo "export SPARK_DAEMON_MEMORY=$SPARK_DAEMON_MEMORY" >> $ENV_FILE
echo "export SPARK_HISTORY_OPTS=$SPARK_HISTORY_OPTS" >> $ENV_FILE
echo "export SPARK_SHUFFLE_OPTS=$SPARK_SHUFFLE_OPTS" >> $ENV_FILE
echo "export SPARK_DAEMON_JAVA_OPTS=$SPARK_DAEMON_JAVA_OPTS" >> $ENV_FILE
cat $ENV_FILE
chmod 755 $ENV_FILE

#Init spark-defaults.conf
DEFAULT_FILE=/opt/spark/conf/spark-defaults.conf
echo "" > $DEFAULT_FILE
echo "# Default system properties included when running spark-submit." >> $DEFAULT_FILE
echo "# This is useful for setting default environmental settings." >> $DEFAULT_FILE
echo "spark.master                     spark://$SPARK_MASTER_IP:$SPARK_MASTER_PORT" >> $DEFAULT_FILE
echo "spark.eventLog.enabled           $SPARK_EVENTlOG_ENABLED" >> $DEFAULT_FILE
echo "spark.eventLog.dir               $SPARK_EVENTlOG_DIR" >> $DEFAULT_FILE
echo "spark.serializer                 $SPARK_SERIALIZER" >> $DEFAULT_FILE
echo "spark.driver.memory              $SPARK_DRIVER_MEMORY" >> $DEFAULT_FILE
echo "spark.executor.extraJavaOptions  $SPARK_EXECUTOR_EXTRAJAVAOPTIONS" >> $DEFAULT_FILE
cat $DEFAULT_FILE

#JAVA_ENV
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
export JRE_HOME=${JAVA_HOME}/jre
export CLASS_PATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export SCALA_HOME=/usr/lib/scala/scala-2.10.6
export PATH=${JAVA_HOME}/bin:/usr/lib/scala/scala-2.10.6/bin:/opt/spark/bin:$PATH

#Start Spark
if [ "$SPARK_ROLE"x = 'master'x ]; then
echo "start spark master ....."
/opt/spark/sbin/start-master.sh --ip $SPARK_IP
else
echo "start spark worker ....."
/opt/spark/sbin/start-slave.sh --ip $SPARK_IP spark://$SPARK_MASTER_IP:$SPARK_MASTER_PORT
fi

