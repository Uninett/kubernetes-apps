# Adapted from Jupyter all-spark-notebooks Dockerfile

FROM jupyter/minimal-notebook

MAINTAINER Gurvinder Singh <gurvinder.singh@uninett.no>

USER root

ENV APACHE_SPARK_VERSION 1.6.1

# Get backports to install JDK 8
RUN echo 'deb http://httpredir.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list

# Install the dependecies
RUN apt-get update && apt-get -y --no-install-recommends install \
    jq openjdk-8-jre fonts-dejavu gfortran gcc && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Fetch Spark
RUN cd /tmp && \
    wget -q http://www-eu.apache.org/dist/spark/spark-${APACHE_SPARK_VERSION}/spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz && \
    echo "667A62D7F289479A19DA4B563E7151D4 spark-1.6.1-bin-hadoop2.6.tgz" | md5sum -c - && \
    tar xzf spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz -C /usr/local && \
    rm spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz

# Install spark and setup corresponding ENV variables
RUN cd /usr/local && ln -s spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6 spark
ENV SPARK_HOME /usr/local/spark
ENV R_LIBS_USER $SPARK_HOME/R/lib
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.9-src.zip

# Run the following 
USER jovyan

# Install Python 3 packages
RUN conda install --yes \
    'ipywidgets=5.1*' \
    'pandas=0.17*' \
    'numexpr=2.5*' \
    'matplotlib=1.5*' \
    'scipy=0.17*' \
    'seaborn=0.7*' \
    'scikit-learn=0.17*' \
    'jsonschema' \
    'pillow' \
    'pip' \
    && conda clean -tipsy

RUN jupyter nbextension enable --py widgetsnbextension --sys-prefix

# Install Python 2 packages
RUN conda create -p $CONDA_DIR/envs/python2 python=2.7 \
    'ipython=4.2*' \
    'ipywidgets=5.1*' \
    'pandas=0.17*' \
    'numexpr=2.5*' \
    'matplotlib=1.5*' \
    'scipy=0.17*' \
    'seaborn=0.7*' \
    'scikit-learn=0.17*' \
    'jsonschema' \
    'pillow' \
    'pip' \
    pyzmq \
    && conda clean -tipsy

# Install Python 2 kernel spec into the Python 3 conda environment which
# runs the notebook server
# Also add any pip package needs to be installed in Python 2
RUN bash -c '. activate python2 && \
    python -m ipykernel.kernelspec --prefix=$CONDA_DIR && \
    pip install thunder-python && \
    . deactivate'

# R packages
RUN conda config --add channels r
RUN conda install --yes \
    'r-base=3.2*' \
    'r-irkernel=0.5*' \
    'r-ggplot2=1.0*' \
    'r-rcurl=1.95*' && conda clean -tipsy

# Apache Toree kernel for Spark and notebook interaction
RUN pip install toree==0.1.0.dev7
RUN jupyter toree install --user

# Scala Spark kernel spec
RUN mkdir -p /opt/conda/share/jupyter/kernels/scala
COPY kernel.json /opt/conda/share/jupyter/kernels/scala/

# Set PYSPARK_HOME in the python2 spec
RUN jq --arg v "$CONDA_DIR/envs/python2/bin/python" \
        '.["env"]["PYSPARK_PYTHON"]=$v' \
        $CONDA_DIR/share/jupyter/kernels/python2/kernel.json > /tmp/kernel.json && \
        mv /tmp/kernel.json $CONDA_DIR/share/jupyter/kernels/python2/kernel.json
