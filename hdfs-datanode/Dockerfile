# Debian Jessie Backports

FROM debian@sha256:19671abba70026f3a480f911712305f61fc0c7fc57925f89427b724349d033dd

MAINTAINER Gurvinder Singh <gurvinder.singh@uninett.no>

ENV HADOOP_VERSION 2.7.2

# Install the dependecies
RUN apt-get update && apt-get -y --no-install-recommends install \
    openjdk-8-jre wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Fetch HDFS
RUN cd /tmp && \
    wget -q http://apache.uib.no/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
    echo "C442BD89B29CAB9151B5987793B94041 hadoop-${HADOOP_VERSION}.tar.gz" | md5sum -c - && \
    tar xzf hadoop-${HADOOP_VERSION}.tar.gz -C /usr/local && \
    rm hadoop-${HADOOP_VERSION}.tar.gz

RUN cd /usr/local && ln -s hadoop-${HADOOP_VERSION} hadoop

# Install Tini
RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.9.0/tini && \
    echo "faafbfb5b079303691a939a747d7f60591f2143164093727e870b289a44d9872 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# TCP	50010	dfs.datanode.address		port for data transfer
# TCP	50020	dfs.datanode.ipc.address	ipc server
# TCP	50075	dfs.datanode.http.address	http server
# TCP	50475	dfs.datanode.https.address	https server

EXPOSE 50010 50020 50075 50475

ENTRYPOINT ["tini", "--"]

CMD ["/usr/local/hadoop/bin/hdfs", "datanode"]
