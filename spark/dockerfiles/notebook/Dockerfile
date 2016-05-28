FROM gurvin/spark-worker-base

MAINTAINER Gurvinder Singh <gurvinder.singh@uninett.no>

# Install inkscape needed for LateX export
RUN apt-get update && apt-get install -yq --no-install-recommends \
    inkscape \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Setup Jupyter Config and notebooks directory
ENV NOTEBOOKS_CONFIG_DIR /opt/jupyter/config
RUN mkdir -p $NOTEBOOKS_CONFIG_DIR
COPY jupyter_notebook_config.py $NOTEBOOKS_CONFIG_DIR/
RUN mkdir -p /notebooks

# Apache Toree kernel for Spark and notebook interaction
RUN pip install toree==0.1.0.dev7
RUN jupyter toree install --ToreeInstall.prefix=$CONDA_DIR --ToreeInstall.toree_opts=--nosparkcontext

# Set PYSPARK_HOME in the python2 spec
RUN jq --arg v "$CONDA_DIR/envs/python2/bin/python" \
        '.["env"]["PYSPARK_PYTHON"]=$v' \
        $CONDA_DIR/share/jupyter/kernels/python2/kernel.json > /tmp/kernel.json && \
        mv /tmp/kernel.json $CONDA_DIR/share/jupyter/kernels/python2/kernel.json

# Start notebook server
COPY start-notebook.sh /usr/local/bin/
CMD ["start-notebook.sh"]