#!/bin/bash

# Strict mode
set -euo pipefail

unset SPARK_MASTER_PORT

if [ -z ${SPARK_MASTER_SERVICE_HOST+x} ]; then
	echo "spark.master local[1]" >> $SPARK_HOME/conf/spark-defaults.conf
else
	echo "spark.master spark://${SPARK_MASTER_SERVICE_HOST:-spark-master}:${SPARK_MASTER_SERVICE_PORT:-7077}" >> $SPARK_HOME/conf/spark-defaults.conf
fi
echo "spark.driver.memory ${SPARK_DRIVER_MEMORY:-1g}" >> $SPARK_HOME/conf/spark-defaults.conf
echo "spark.driver.cores ${SPARK_DRIVER_CORES:-1}" >> $SPARK_HOME/conf/spark-defaults.conf
echo "spark.local.dir ${SPARK_LOCAL_DIRS:-/tmp}" >> $SPARK_HOME/conf/spark-defaults.conf

jupyter notebook --config $NOTEBOOKS_CONFIG_DIR/jupyter_notebook_config.py
