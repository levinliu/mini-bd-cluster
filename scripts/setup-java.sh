#!/bin/bash
source "/vagrant/scripts/common.sh"

function installLocalJava {
	echo "installing local jdk"
	FILE=/vagrant/resources/$JAVA_ARCHIVE
	tar -xzf $FILE -C /usr/local
}

function installRemoteJava {
	echo "install remote jdk"
	yum install -y jdk-8u191-linux-i586
}

function setupJava {
	echo "setting up java"
	if resourceExists $JAVA_ARCHIVE; then
		ln -s /usr/local/jdk1.8.0_191 /usr/local/java
	else
		ln -s /usr/lib/jvm/jre /usr/local/java
	fi
}

function setupEnvVars {
	echo "creating java environment variables"
	echo export JAVA_HOME=/usr/local/java >> /etc/profile.d/java.sh
	echo export PATH=\${JAVA_HOME}/bin:\${PATH} >> /etc/profile.d/java.sh
}

function installJava {
	if resourceExists $JAVA_ARCHIVE; then
		installLocalJava
	else
		installRemoteJava
	fi
	#https://blog.csdn.net/w616589292/article/details/39697557
	yum install -y glibc.i686
}

echo "setup java"
installJava
setupJava
setupEnvVars
