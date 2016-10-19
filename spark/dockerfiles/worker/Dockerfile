FROM gurvin/spark-worker-base:latest

MAINTAINER Gurvinder Singh <gurvinder.singh@uninett.no>

COPY start-worker.sh /usr/local/bin/

# Create directory where data will be mounted on all workers
ENV DATA_DIR /data
RUN mkdir -p $DATA_DIR

EXPOSE 8081/tcp

CMD ["start-worker.sh"]