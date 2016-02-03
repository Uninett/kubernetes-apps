FROM gurvin/spark-base:latest

ADD start.sh /
ADD log4j.properties /opt/spark/conf/log4j.properties
EXPOSE 8081

ENTRYPOINT ["/start.sh"]
