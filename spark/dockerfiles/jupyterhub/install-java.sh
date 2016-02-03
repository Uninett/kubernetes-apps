#!/bin/bash
# webupd8team key
apt-key adv --keyserver keyserver.ubuntu.com --recv EEA14886

DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
CODENAME=$(lsb_release -cs)

echo "deb http://ppa.launchpad.net/webupd8team/java/${DISTRO} ${CODENAME} main" > \
  /etc/apt/sources.list.d/webupd8java.list
apt-get -y update
echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
apt-get -y install oracle-java8-installer
