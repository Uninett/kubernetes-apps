FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq  \
    && apt-get install -y nfs-kernel-server nfs-common
 
RUN mkdir /exports \
    && echo "/exports *(rw,fsid=0,insecure,no_root_squash,no_subtree_check)" >> /etc/exports \
    && echo "Serving /exports" \
    && /usr/sbin/exportfs -a

RUN chmod 777 /exports

EXPOSE 111/udp 111/tcp 2049/udp 2049/tcp 20049/udp 20049/tcp

COPY nfs-server.default /etc/default/nfs-kernel-server
COPY run.sh /run.sh
ENTRYPOINT  [ "/run.sh" ]