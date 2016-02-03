#!/bin/bash

# Copyright 2015 The Kubernetes Authors All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

. /start-common.sh

echo "spark.master spark://{SPARK_MASTER_SERVICE_HOST:-spark-master}:${SPARK_MASTER_SERVICE_PORT:-7077}" >> /opt/spark/conf/spark-defaults.conf

# Run spark-class directly so that when it exits (or crashes), the pod restarts.
/opt/spark/bin/spark-class org.apache.spark.deploy.worker.Worker --webui-port 8081