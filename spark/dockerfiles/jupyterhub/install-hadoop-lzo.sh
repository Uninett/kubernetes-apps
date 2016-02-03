#!/bin/bash
apt-key adv --keyserver keyserver.ubuntu.com --recv D1CA74A1
DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
CODENAME=$(lsb_release -cs)

echo "deb http://archive.cloudera.com/gplextras5/${DISTRO}/${CODENAME}/amd64/gplextras ${CODENAME}-gplextras5 contrib" > \
  /etc/apt/sources.list.d/cloudera-gplextras5.list
apt-get -y update
apt-get -y install hadoop-lzo
