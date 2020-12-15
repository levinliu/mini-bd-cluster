#!/bin/bash

VAG_RESOURCE=/vagrant/resources
#java
JAVA_ARCHIVE=jdk-8u191-linux-i586.tar.gz

SSHPASS_FILE=sshpass-1.06.tar.gz
#hadoop
HADOOP_PREFIX=/usr/local/hadoop
HADOOP_CONF=$HADOOP_PREFIX/etc/hadoop
HADOOP_VERSION=hadoop-2.7.7
HADOOP_ARCHIVE=$HADOOP_VERSION.tar.gz
HADOOP_MIRROR_DOWNLOAD=../resources/hadoop-2.7.7.tar.gz
HADOOP_RES_DIR=/vagrant/resources/hadoop
#spark
SPARK_VERSION=spark-2.4.6
SPARK_FILE_NAME=spark-2.4.6-bin-hadoop2.7
SPARK_ARCHIVE=$SPARK_FILE_NAME.tgz
SPARK_MIRROR_DOWNLOAD=../resources/$SPARK_FILE_NAME.tgz
SPARK_RES_DIR=/vagrant/resources/spark
SPARK_CONF_DIR=/usr/local/spark/conf
#ssh
SSH_RES_DIR=/vagrant/resources/ssh
RES_SSH_COPYID_ORIGINAL=$SSH_RES_DIR/ssh-copy-id.original
RES_SSH_COPYID_MODIFIED=$SSH_RES_DIR/ssh-copy-id.modified
RES_SSH_CONFIG=$SSH_RES_DIR/config

function resourceExists {
	FILE=/vagrant/resources/$1
	if [ -e $FILE ]
	then
		return 0
	else
		return 1
	fi
}

function fileExists {
	FILE=$1
	if [ -e $FILE ]
	then
		return 0
	else
		return 1
	fi
}

#echo "common loaded"
