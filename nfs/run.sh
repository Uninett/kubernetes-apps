#!/bin/bash
echo "Starting NFS Server"

rpcbind
service nfs-kernel-server start

echo "Started"

echo "Done all tasks - Running continious loop to keep this container alive"
while true; do
  sleep 3600
done