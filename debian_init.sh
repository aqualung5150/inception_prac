#! /bin/bash

# su -
# visudo
# apt-get update
# apt-get install -y sudo
sudo apt-get install -y apt-transport-https \
ca-certificates \
curl \
software-properties-common \
git \
make \
vim \
systemd

# Restart terminal

# sudo vim /etc/resolv.conf
# Add
# nameserver 8.8.8.8
# nameserver 8.8.4.4
# to /etc/resolv.conf

# After installing docker
# sudo usermod -aG docker $USER
# restart VM