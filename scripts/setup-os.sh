#!/bin/bash
source "/vagrant/scripts/common.sh"

function setupYum {
	echo "update yum"
	yum install -y yum-plugin-fastestmirror
	# yum update commmand will update the kernel of linux, we need to 'sudo /etc/init.d/vboxadd setup' or it will has issue on synchronized folder
	# https://blog.csdn.net/meegomeego/article/details/50715694
	yum -y update
	if [ -f /etc/init.d/vboxadd ] ; then /etc/init.d/vboxadd setup ; fi
	#curl -o /etc/yum.repos.d/CentOS-Base.repo
	# http://mirrors.myhuaweicloud.com/repo/CentOS-Base-6.repo
	yum clean all
	yum makecache
	#https://blog.csdn.net/qq_40572277/article/details/87933288
	yum -y install gcc
}

echo "setup os"
setupYum
