#!/bin/bash

# Strict mode
set -euo pipefail

unset SPARK_MASTER_PORT

# Run spark-class directly so that when it exits (or crashes), the pod restarts.
$SPARK_HOME/bin/spark-class org.apache.spark.deploy.worker.Worker --webui-port 8081 \
	 -c ${SPARK_WORKER_CORES:-1} -m ${SPARK_WORKER_MEMORY:-1g} -d ${SPARK_WORKER_DIRS:-/tmp} \
	 "spark://${SPARK_MASTER_SERVICE_HOST:-spark-master}:${SPARK_MASTER_SERVICE_PORT:-7077}"
