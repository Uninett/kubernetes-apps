#!/bin/bash

# Strict mode
set -euo pipefail

echo "spark.deploy.recoveryMode FILESYSTEM" > $SPARK_HOME/conf/spark-defaults.conf
echo "spark.deploy.recoveryDirectory ${SPARK_RECOVERY_DIR}" >> $SPARK_HOME/conf/spark-defaults.conf

echo "SPARK_PUBLIC_DNS=${SPARK_PUBLIC_DNS}" > $SPARK_HOME/conf/spark-env.sh

unset SPARK_MASTER_PORT

# Run spark-class directly so that when it exits (or crashes), the pod restarts.
$SPARK_HOME/bin/spark-class org.apache.spark.deploy.master.Master --webui-port 8080
