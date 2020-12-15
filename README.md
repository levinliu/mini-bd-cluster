Mini BigData Cluster
============================

# 1. Introduction

Vagrant with CentOS7

1. node1 : HDFS NameNode + Spark Master
2. node2 : YARN ResourceManager + JobHistoryServer + ProxyServer
3. node3 : HDFS DataNode + YARN NodeManager + Spark Slave


# 2. Start

## 2.1 Preparation 
Download the following package into resources folder as we cannot upload bi files (>100mb), they are:
- [jdk](http://download.oracle.com/otn-pub/java/jdk/8u25-b17/jdk-8u191-linux-i586.tar.gz)
- [hadoop](http://apache.crihan.fr/dist/hadoop/common/stable/hadoop-2.7.7.tar.gz)
- [spark](http://d3kbcqa49mib13.cloudfront.net/spark-2.4.6-bin-hadoop2.4.tgz)

## 2.2 Build the cluster nodes

1. Run ```vagrant up``` to create the VM.
2. Run ```vagrant ssh``` to get into your VM.
3. Run ```vagrant destroy``` when you want to destroy and get rid of the VM.



# 3. Setup cluster before to start cluster

1. $HADOOP_PREFIX/bin/hdfs namenode -format myhadoop
or hadoop namenode -format myhadoop


## 4. Start Hadoop Daemons (HDFS + YARN)
SSH into node1 and issue the following commands to start HDFS.
2. $HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start namenode

Then can check name node dfshealth via 10.211.55.101:50070
LOG:
http://10.211.55.101:50070/logs/
http://10.211.55.101:50070/logs/hadoop-root-namenode-node1.log

3. $HADOOP_PREFIX/sbin/hadoop-daemons.sh --config $HADOOP_CONF_DIR --script hdfs start datanode

Then verify data node on:
http://10.211.55.101:50070/dfshealth.html#tab-datanode

SSH into node2 and issue the following commands to start YARN.

1. $HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR start resourcemanager

Then can verify HadoopYarn RM via :
http://10.211.55.102:8088/cluster
LOGS: http://10.211.55.102:8088/logs
CONF: http://10.211.55.102:8088/conf
More options on TOOLS

2. $HADOOP_YARN_HOME/sbin/yarn-daemons.sh --config $HADOOP_CONF_DIR start nodemanager

Then can check node manager on each data node:
 http://10.211.55.103:8042/node
 http://10.211.55.104:8042/node
 http://10.211.55.103:8042/logs/

3. $HADOOP_YARN_HOME/sbin/yarn-daemon.sh start proxyserver --config $HADOOP_CONF_DIR
Then can visit proxy server:
http://10.211.55.102:8089/

4. $HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh start historyserver --config $HADOOP_CONF_DIR
Check job history: http://10.211.55.102:19888/jobhistory


### Test YARN
Run the following command to make sure you can run a MapReduce job.

```
yarn jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.6.0.jar pi 2 100
```

## Start Spark in Standalone Mode
SSH into node1 and issue the following command.

1. $SPARK_HOME/sbin/start-all.sh

### Test Spark on YARN
You can test if Spark can run on YARN by issuing the following command. Try NOT to run this command on the slave nodes.
```
$SPARK_HOME/bin/spark-submit --class org.apache.spark.examples.SparkPi \
    --master yarn-cluster \
    --num-executors 10 \
    --executor-cores 2 \
    $SPARK_HOME/examples/jars/spark-examples*.jar \
    100
```

### Test Spark using Shell
Start the Spark shell using the following command. Try NOT to run this command on the slave nodes.

```
$SPARK_HOME/bin/spark-shell --master spark://node1:7077
```

Then go here https://spark.apache.org/docs/latest/quick-start.html to start the tutorial. Most likely, you will have to load data into HDFS to make the tutorial work (Spark cannot read data on the local file system).

# 6. Web UI
You can check the following URLs to monitor the Hadoop daemons.

1. [NameNode](http://10.211.55.101:50070/dfshealth.html)
2. [ResourceManager](http://10.211.55.102:8088/cluster)
3. [JobHistory](http://10.211.55.102:19888/jobhistory)
4. [Spark](http://10.211.55.101:8080)

