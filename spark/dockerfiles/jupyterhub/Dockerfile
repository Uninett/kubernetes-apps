FROM ipython/scipyserver

# Remote spark tarball
# ADD http://d3kbcqa49mib13.cloudfront.net/spark-1.6.0-bin-hadoop2.6.tgz /
# WORKDIR /opt
# RUN tar xfz /spark-1.6.0-bin-hadoop2.6.tgz
# RUN rm /spark-1.6.0-bin-hadoop2.6.tgz
# Local spark tarball
ADD /spark-1.6.0-bin-hadoop2.6.tgz /opt
# Spark tarball end

RUN mv /opt/spark-1.6.0-bin-hadoop2.6/ /opt/spark
ADD install-java.sh /
RUN chmod u+x /install-java.sh
RUN /install-java.sh
ADD install-hadoop-lzo.sh /
RUN chmod u+x /install-hadoop-lzo.sh
RUN /install-hadoop-lzo.sh
#ADD hadoop-conf /etc/hadoop/conf
#ADD spark-env.sh /opt/spark/conf/spark-env.sh
ADD spark-defaults.conf /opt/spark/conf/spark-defaults.conf
RUN ipython2 profile create spark
ADD ipython_notebook_config.py /root/.ipython/profile_spark/ipython_notebook_config.py
ADD 00-pyspark-setup.py /root/.ipython/profile_spark/startup/00-pyspark-setup.py
ENV PATH $PATH:/opt/spark/bin
RUN mkdir /tmp/spark-events
ADD notebook.sh /
RUN chmod u+x /notebook.sh
CMD ["/notebook.sh"]
