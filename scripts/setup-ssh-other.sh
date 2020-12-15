#!/bin/bash

echo "setup ssh pub key"
mkdir -p $HOME/.ssh
#curl http://master:14001/id_rsa.pub -o master.rsa.pub
touch $HOME/.ssh/authorized_keys
echo -n >> $HOME/.ssh/authorized_keys
cat /vagrant/master-ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
echo -n >> $HOME/.ssh/authorized_keys
cat /vagrant/other-ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
cp /vagrant/other-ssh/id_rsa $HOME/.ssh
cp /vagrant/other-ssh/id_rsa.pub $HOME/.ssh
chmod 0600 $HOME/.ssh/id_rsa
ssh-add $HOME/.ssh/id_rsa
systemctl restart sshd.service
echo "done ssh pub key setup on other"
