#!/bin/bash

kubectl create -f spark-master.json
sleep 60
kubectl get pods spark-master
sleep 10
kubectl create -f spark-master-service.json
kubectl create -f spark-master-http-service.json
kubectl get services | grep -P spark\|SELECTOR
sleep 30
kubectl create -f spark-worker-controller.json
kubectl create -f spark-ipython-notebook.json
kubectl create -f spark-driver.json
sleep 90
kubectl create -f spark-ipython-notebook-service.json
kubectl get rc
kubectl get pods

