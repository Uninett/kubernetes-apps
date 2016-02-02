#!/bin/bash

K8S_VERSION=1.1.3

if [ "$1" == "start" ]; then
   # Run etcd cluster as it is required to store data by kubernetes
   docker run --net=host --name=etcd-test -d gcr.io/google_containers/etcd:2.0.12 /usr/local/bin/etcd --addr=127.0.0.1:4001 --bind-addr=0.0.0.0:4001 --data-dir=/var/etcd/data

   # wait untill etcd is ready
   sleep 5

   # Start Kubernetes master
   docker run \
          --volume=/:/rootfs:ro \
          --volume=/sys:/sys:ro \
          --volume=/dev:/dev \
          --volume=/var/lib/docker/:/var/lib/docker:ro \
          --volume=/var/lib/kubelet/:/var/lib/kubelet:rw \
          --volume=/var/run:/var/run:rw \
          --net=host \
          --pid=host \
          --privileged=true \
          --name=k8s-hyper \
          -d \
          gcr.io/google_containers/hyperkube:v${K8S_VERSION} \
          /hyperkube kubelet --containerized --hostname-override="127.0.0.1" --address="0.0.0.0" --api-servers=http://localhost:8080 --cluster-dns="10.0.0.10" --allow-privileged=true --cluster-domain="cluster.local" --config=/etc/kubernetes/manifests

   # Start kubernetes service proxy
   docker run -d --net=host --name=k8s-proxy --privileged gcr.io/google_containers/hyperkube:v${K8S_VERSION} /hyperkube proxy --master=http://127.0.0.1:8080 --v=2

   # Download kubectl if required
   if [ -s "kubectl" ]
   then
       echo "Kubectl is already present"
       export PATH=$PATH:$PWD
   else
       wget https://storage.googleapis.com/kubernetes-release/release/v${K8S_VERSION}/bin/linux/amd64/kubectl
       chmod +x kubectl
       export PATH=$PATH:$PWD
   fi

   # Configure kubeconfig, so that kubectl can talk to new cluster
   kubectl config set-cluster docker-test --server=http://localhost:8080
   kubectl config set-context docker-test --cluster=docker-test
   kubectl config use-context docker-test

   sleep 5
   # Print the cluster node info
   kubectl get nodes

elif [ "$1" == "stop" ]; then
    docker rm -f etcd-test
    docker rm -f $(docker ps -aq -f name=k8s\*)
else
    echo "Please specify start or stop to test kubernetes cluster"
fi
