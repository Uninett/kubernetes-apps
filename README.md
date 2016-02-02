This repo contains various application which we are working to deploy on kubernetes cluster. To start, run cluster.sh which sets up kubernetes cluster on your laptop for testing purposes. It assumes you have docker up and running on your laptop already. You can setup the kubernetes version in ```cluster.sh``` file.

```
./cluster.sh start
```

To destroy cluster run following commands
```
./cluster.sh stop
```
