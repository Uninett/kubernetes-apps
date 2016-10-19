FROM gurvin/spark-base:latest

MAINTAINER Gurvinder Singh <gurvinder.singh@uninett.no>

COPY start-master.sh /usr/local/bin/

# Create Recovery directory
ENV SPARK_RECOVERY_DIR /data/spark-master

EXPOSE 8080/tcp 7077/tcp

CMD ["start-master.sh"]