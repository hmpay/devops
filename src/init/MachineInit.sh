#!/bin/bash
set -ex

echo "init all machine start"
echo "======================================================="
uname -a
whoam
env
echo "======================================================="

echo "Install root ssh config -------------------------------"
# no user interaction
ssh-keygen -t rsa -P "" -f /.ssh/id_rsaeygen

cat ${Admin_SSH_Public_key} > /root/.ssh/authorized_keys
echo "Install root ssh config end ---------------------------"

echo "Install Git start -------------------------------------"
yum install git -y
echo "Install Git client end --------------------------------"

echo "Install Docker start ----------------------------------"
yum remove docker \
  docker-client \
  docker-client-latest \
  docker-common \
  docker-latest \
  docker-latest-logrotate \
  docker-logrotate \
  docker-engine

yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce docker-ce-cli containerd.io
systemctl start docker
# systemctl restart docker
docker -v
echo "Install Docker end -----------------------------------"

echo "init all machine completed"
echo "Success~"
echo "======================================================="
echo "ᕙ(`▿´)ᕗ  ᕙ(`▿´)ᕗ  ᕙ(`▿´)ᕗ  ᕙ(`▿´)ᕗ ᕙ(`▿´)ᕗ ᕙ(`▿´)ᕗ"
echo "======================================================="



