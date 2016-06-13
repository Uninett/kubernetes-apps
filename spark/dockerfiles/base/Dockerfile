# Debian Jessie Backports

FROM debian@sha256:0d7633d9cdbb676b7c6d5f0943c7ad26e287e196e8ad019af5b50bf342b2e1e8

MAINTAINER Gurvinder Singh <gurvinder.singh@uninett.no>

ENV APACHE_SPARK_VERSION 1.6.1

# Install the dependecies
RUN apt-get update && apt-get -y --no-install-recommends install \
    openjdk-8-jre wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Fetch Spark
RUN cd /tmp && \
    wget -q http://www-eu.apache.org/dist/spark/spark-${APACHE_SPARK_VERSION}/spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz && \
    echo "667A62D7F289479A19DA4B563E7151D4 spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz" | md5sum -c - && \
    tar xzf spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz -C /usr/local && \
    rm spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz

# Install spark and setup corresponding ENV variables
RUN cd /usr/local && ln -s spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6 spark
ENV SPARK_HOME /usr/local/spark
ENV R_LIBS_USER $SPARK_HOME/R/lib
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.9-src.zip
ENV PATH $SPARK_HOME/bin:$PATH

# Spark logging properties
COPY log4j.properties $SPARK_HOME/conf/log4j.properties

# Install Tini
RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.9.0/tini && \
    echo "faafbfb5b079303691a939a747d7f60591f2143164093727e870b289a44d9872 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

ENTRYPOINT ["tini", "--"]
