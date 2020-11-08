#!/bin/bash
set -ex

echo "Init all machine ======================================"
uname -a
whoami
env
echo "======================================================="

echo "Install root ssh config -------------------------------"
# no user interaction
ssh-keygen -t rsa -P "" -f /.ssh
echo "${OPS_SSH_Public_key}" > /root/.ssh/authorized_keys
echo "Install root ssh config end ---------------------------"

echo "Install User ------------------------------------------"
useradd ${OPS_USER_NAME};groupadd ${OPS_USER_NAME}
# generate ssh key for user
ssh-keygen -t rsa -P "" -f /home/${OPS_USER_NAME}/.ssh
echo "${OPS_SSH_Public_key}" > /home/${OPS_USER_NAME}/.ssh/authorized_keys
chown -R ${OPS_USER_NAME}:${OPS_USER_NAME} /home/${OPS_USER_NAME}/.ssh
chmod 600 /home/${OPS_USER_NAME}/.ssh/authorized_keys
# add to sudoers file
echo "${OPS_USER_NAME}   ALL=(ALL)       ALL" >> /etc/sudoers
echo "Install Use End ---------------------------------------"

echo "Install Git -------------------------------------------"
yum install git -y
echo "Install Git client end --------------------------------"

echo "Install Docker ----------------------------------------"
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
gpasswd -a ${OPS_USER_NAME} docker
newgrp docker
docker -v
echo "Install Docker end ------------------------------------"

echo "Init all machine completed"
echo "Success ~"
echo "======================================================="
echo "ᕙ(\`▿\´)ᕗ ᕙ(\`▿\´)ᕗ ᕙ(\`▿\´)ᕗ ᕙ(\`▿\´)ᕗ"
echo "======================================================="


