# Debian Jessie Backports

FROM debian:jessie-backports

MAINTAINER Gurvinder Singh <gurvinder.singh@uninett.no>

ENV APACHE_SPARK_VERSION 2.0.0

# Install the dependecies
RUN apt-get update && apt-get -y --no-install-recommends install \
    openjdk-8-jre wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Fetch Spark
# RUN cd /tmp && \
#     wget -q http://www-eu.apache.org/dist/spark/spark-${APACHE_SPARK_VERSION}/spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz && \
#     echo "667A62D7F289479A19DA4B563E7151D4 spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz" | md5sum -c - && \
#     tar xzf spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz -C /usr/local && \
#     rm spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz
RUN cd /tmp && \
    wget -q http://spark-dist.paas.uninett.no/spark-2.0.0-bin-spark-2.0.0+uninett1.tgz && \
    tar xzf spark-2.0.0-bin-spark-2.0.0+uninett1.tgz -C /usr/local && \
    rm spark-2.0.0-bin-spark-2.0.0+uninett1.tgz

# Install spark and setup corresponding ENV variables
RUN cd /usr/local && ln -s spark-2.0.0-bin-spark-2.0.0+uninett1 spark
ENV SPARK_HOME /usr/local/spark
ENV R_LIBS_USER $SPARK_HOME/R/lib
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.1-src.zip
ENV PATH $SPARK_HOME/bin:$PATH

# Spark logging properties
COPY log4j.properties $SPARK_HOME/conf/log4j.properties
COPY spark-defaults.conf $SPARK_HOME/conf/spark-defaults.conf

# Install Tini
RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.10.0/tini && \
    echo "1361527f39190a7338a0b434bd8c88ff7233ce7b9a4876f3315c22fce7eca1b0 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

ENTRYPOINT ["tini", "--"]
