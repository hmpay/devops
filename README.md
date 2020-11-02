# devops

[![standard-readme compliant](https://img.shields.io/badge/standard--readme-OK-green.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

`devops` is a steps of how to archive the devops target for `hmpay` system.

![](./assets/design.png)

## Table of Contents
- [Background](#background)
- [Install](#install)
- [Usage](#usage)
- [Maintainers](#maintainers)
- [Contributing](#contributing)
- [License](#license)

## Background

## Install

### Step1. Init Jumping Machine SSH Login And User

```bash
# login from from cloud console and execute.
cat "xxxxxxx" > /root/.ssh/authorized_keys

# generate ssh key for root user
ssh-keygen -t rsa

# add huser
useradd huser;groupadd huser
su huser
# generate ssh key for huser user
ssh-keygen -t rsa

cat "xxxxxxx" > /home/huser/.ssh/authorized_keys
```

> login to other machines that can ssh login from jumping machine.

### Step2. Init `huser` for all machine from cloud console

> add the huser from cloud console
```bash
hostname hm-api

rm -rf /root/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDv4961KtLBq9L2KY3VeB1U4Th8gOqHjvnpMJSV8SDyLDGTa5sYKp6ZDn3gVp4X7NUhI8zGZ7PE3CEIygi86jfa4S6Pwe4gQV7dE7KQWJ+j36Zw+rU1YoYIkHfGWfzOcWL1/TFkTdYaNxj+nAeUAEF1lRAD5jmv9hw7ZICDrUYQLYGY1l81ogyPUI9YM5STn3F+ZeqX9Foj5gqB2XfgLw1WIANT9A2yu8oGeD3nu5TZGIVafvZFA7f/wfmndtDlVW3nR+5Ebe71v8tqGHc3ZhNViElS0/1jTJpczCEW3XE5WOAwNBirV+1lKQ9ov1ktekDYPEEtID3TJjT1kD9mPzSqGRZC5Ikp3bDkBqMeZOOA3g63ckfWr7+6HEUxrvgs1kJygIc+GbFEgZtiTIVwyygLC9rCZFLbQbgK87sz7J1tTK6roPCP8d3RVAmKRo0tCkGzoFNRdS8PXRQnTdwEEA1U4ZNp/QV8X3zxVtgE87FMUp09lqdIGCanBZmUYL0i/us= root@iZuf6dcz9uks340jahtx57Z" > /root/.ssh/authorized_keys

useradd huser;groupadd huser
su huser
mkdir /home/huser/.ssh
rm -rf /home/huser/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIOs9Y7Eb4BRwtx53zW2RLW9Hei+3lvi53p0vDMwKGuiBfsRfeuGrMqviiONLJy5t18ST0ghYwJpY4xUSXTERCaOK1oluhMC8a2XzBc4lPi18T1dZ9wapy4zTmwcKwnpuzty/qBzDghHOCctUGhGynQW9e0zVlkJ0tqupGBKdcFrnAtQdvRkDEfy9D/PAyAlFmxtVUXgX3Af6p4LZv4aoZcncjh3KyYe7cewrCTSWbchgyqDg5Kh5oKMPhfUCjyjR3LneubGpWquWUMgUI4069QwsbfvigeTro65W7ZY/4ETyJJ2YM6v9RTlcg9+iIppuOiViDOKGIFDw4H8cHTtvt097ADqv7dnWL5uZsCGEKcT/uA37tZx7uT6i8U5p8qS91Gov6F6+f3xMkTD4mOsJxjIkfrK5YCQWC/Cxhk9xfTi9hkki85Sxa8V5RiCbhHoU8vGIbVD+MY1ZAoF+7YfBT9zG4N5cOIuWMxSAor5UxB1Q1MYTdjC1jRpT6WpgjdaM= huser@iZuf6dcz9uks340jahtx57Z" > /home/huser/.ssh/authorized_keys

chmod 600 /home/huser/.ssh/authorized_keys
```

#### init the ssh config for huser user
```bash
echo "\
Host hm-slb
Hostname 172.19.182.202
User huser

Host hm-base
Hostname 172.19.182.203
User huser

Host hm-db
Hostname 172.19.182.204
User huser

Host hm-biz
Hostname 172.19.182.200
User huser

Host hm-api
Hostname 172.19.182.201
User huser" > /home/huser/.ssh/config
chmod 600 /home/huser/.ssh/config
```

add `huser` to sudoers file

```bash
vi /etc/sudoers

# below root    ALL=(ALL)       ALL
huser   ALL=(ALL)       ALL
```

### Step3. Login `huser` for all machine from ops machine

```bash
# login to ops machine

# use pwd or add public key
ssh huser@139.196.165.125
ssh hm-slb
ssh hm-base
ssh hm-db
ssh hm-biz
ssh hm-api
```

### step4. Init Docker Env
```bash
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo systemctl start docker

# add huser to docker group
sudo gpasswd -a huser docker
newgrp docker
docker run hello-world
```

```
docker swarm init
# docker swarm join --token SWMTKN-1-4p8du2pv1sbc2xuzp2d5pyuwpjuh1yd281x7gg4m4ih5237fjr-7qpfeio2jkcv1jf2ueto5nlhy 172.19.182.199:2377
```

## Maintainers

[@alex.zhang](https://github.com/alex.zhang)

## Contributing

PRs accepted.

Small note: If editing the README, please conform to the [standard-readme](https://github.com/RichardLitt/standard-readme) specification.

## License

MIT © 2020 alex.zhang
