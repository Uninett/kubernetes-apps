# Spark example

Thanks for official dockerfiles for Spark from [Kubernetes application images](https://github.com/kubernetes/application-images) on which this deployment is based upon.
### You can use cluster.sh to setup the spark cluster

Following this example, you will create a functional [Apache Spark](http://spark.apache.org/) cluster using Kubernetes and [Docker](http://docker.io).

You will setup a Spark master service and a set of Spark workers using Spark's [standalone mode](http://spark.apache.org/docs/latest/spark-standalone.html) with Jupyterhub notebook under spark-project

For the impatient expert, jump straight to the [tl;dr](#tldr) section.

### Sources

Source is freely available at:
* Docker image - under dockerfiles folder
* Docker Trusted Build - https://hub.docker.com/search?q=gurvin

## Step Zero: Prerequisites

This example assumes you have a Kubernetes cluster installed and running, and that you have installed the ```kubectl``` command line tool somewhere in your path. Please see the [getting started](../README.md) for installation instructions for your local host with docker installed.

Create project namespace ```spark-project```, as in Kubernetes pods submitted in a namespace will be rejected without namespace being created already.

```shell
$ kubectl create -f spark-namespace.yaml
```

you can see the newly created namespace as

```shell
$ kubectl get namespace
NAME            LABELS    STATUS    AGE
default         <none>    Active    4h
spark-project   <none>    Active    4h
```

## Step One: Start your Spark components

This deployment creates
* Master replication controller with 1 replica, so that master keep running in case of failure
* Master service to allow workers tobe able to connect to master
* Master web UI service on port 30001 so that you can see the current status of spark cluster
* Spark worker controller with 3 workers
* Spark driver so that user can connect to it ans use ```pyspark, spark-submit,spark-shell..```
* Jupyterhub controller so that you can use IPython notebook with Spark
* Jupyterub service to be exposed on port 30002

To create the above mentioned resources, run the kubectl as

```shell
$ kubectl create -f deployment/
```

Now if you should see 3 new services created under our namespace as
```shell
$ kubectl get svc --namespace=spark-project
NAME           CLUSTER_IP   EXTERNAL_IP   PORT(S)    SELECTOR                 AGE
jupyterhub     10.0.0.120   nodes         8888/TCP   component=jupyterhub     4h
spark-master   10.0.0.121   <none>        7077/TCP   component=spark-master   4h
spark-webui    10.0.0.4     nodes         8080/TCP   component=spark-master   4h
```

Also you can see the pods running under our namespace for correcponding components as
```shell
$  kubectl get pods --namespace=spark-project
NAME                            READY     STATUS    RESTARTS   AGE
jupyterhub-controller-8mi28     1/1       Running   0          4h
spark-driver-controller-u0s3b   1/1       Running   0          4h
spark-master-controller-uav6a   1/1       Running   0          4h
spark-worker-controller-6iynj   1/1       Running   0          4h
spark-worker-controller-ldiuj   1/1       Running   0          4h
spark-worker-controller-s2hmz   1/1       Running   0          4h
```

Connect to http://10.0.0.4:8080 to see the status of the master, but if you are running kubernetes somewhere on VMs then you should use the url as http://<VM-IP>:30001 . This will show the Spark UI showing information about 3 workers and it might take some time due to JVM process starting delay, referesh the page for upto date information.

## Step Two: Do something with the cluster

```shell
$ kubectl get pods --namespace=spark-project -l component=spark-driver
NAME                            READY     STATUS    RESTARTS   AGE
spark-driver-controller-u0s3b   1/1       Running   0          4h

$ kubectl exec -it spark-driver-controller-u0s3b bash

# pyspark

>>> import socket, resource
>>> sc.parallelize(range(1000)).map(lambda x: (socket.gethostname(), resource.getrlimit(resource.RLIMIT_NOFILE))).distinct().collect()
[('spark-worker-controller-ehq23', (1048576, 1048576)), ('spark-worker-controller-5v48c', (1048576, 1048576)), ('spark-worker-controller-51wgg', (1048576, 1048576))]
```

## Step Three: Use JupyterHub Notebook
Get the service endpoint info as

```
$ kubectl get svc jupyterhub
NAME         CLUSTER_IP   EXTERNAL_IP   PORT(S)    SELECTOR               AGE
jupyterhub   10.0.0.120   nodes         8888/TCP   component=jupyterhub   5h
```

Connect to http://10.10.0.120:8888 or if you running under VM then use http://<VM-IP>:30002. It will prompt you for password and use ```testing``` as password, you can change this if you like under deployment/jupyterhub-controller.yaml file. Once in you can open New Python notebook and run the following script

```
import socket, resource
sc.parallelize(range(1000)).map(lambda x: (socket.gethostname(), resource.getrlimit(resource.RLIMIT_NOFILE))).distinct().collect()

Output:

[('spark-worker-controller-ehq23', (1048576, 1048576)), ('spark-worker-controller-5v48c', (1048576, 1048576)), ('spark-worker-controller-51wgg', (1048576, 1048576))]
```

Congratulations you have a Spark cluster running on Kubernetes with Jupyter Notebook, you can scale the cluster by just changing the replica count of worker and it will appear automatically under worker section in Spark Master web UI.

## tl;dr

```kubectl create -f spark-namepsace.yaml```

```kubectl create -f deployment```
