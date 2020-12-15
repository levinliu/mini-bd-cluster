#!/bin/bash
source "/vagrant/scripts/common.sh"

function disableFirewall {
	echo "disabling firewall"
	#fix issue: Failed to stop iptables.service: Unit iptables.service not loaded.
  # error reading information on service iptables: No such file or directory
	systemctl stop firewalld
	systemctl status firewalld
	echo "disabled firewall"
}

echo "setup centos network"
disableFirewall
