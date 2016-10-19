#!/bin/bash

# Strict mode
set -euo pipefail

echo "spark.deploy.recoveryDirectory ${SPARK_RECOVERY_DIR}" >> $SPARK_HOME/conf/spark-defaults.conf
echo "spark.ui.reverseProxyUrl  ${SPARK_PUBLIC_DNS}" >> $SPARK_HOME/conf/spark-defaults.conf

echo "SPARK_PUBLIC_DNS=${SPARK_PUBLIC_DNS}" > $SPARK_HOME/conf/spark-env.sh

unset SPARK_MASTER_PORT
mkdir -p $SPARK_RECOVERY_DIR

# Run spark-class directly so that when it exits (or crashes), the pod restarts.
$SPARK_HOME/bin/spark-class org.apache.spark.deploy.master.Master --webui-port 8080
