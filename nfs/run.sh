#!/bin/bash
echo "Starting NFS Server"

rpcbind
service nfs-kernel-server start

echo "Started"

echo "Creating exports directries $EXPORT_DIRS"
cd /exports
mkdir -p $EXPORT_DIRS

echo "Done all tasks - Running continious loop to keep this container alive"
while true; do
  sleep 3600
done