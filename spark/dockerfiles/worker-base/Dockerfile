FROM gurvin/spark-base

MAINTAINER Gurvinder Singh <gurvinder.singh@uninett.no>

# Install the dependencies for Notebook as mentioned in jupyter/minimal-notebook
RUN apt-get update && apt-get install -yq --no-install-recommends \
    git vim jed emacs build-essential python-dev ca-certificates bzip2 unzip jq \
    libsm6 pandoc texlive-latex-base texlive-latex-extra texlive-fonts-extra nano \
    texlive-fonts-recommended texlive-generic-recommended locales libxrender1 less \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Configure environment
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH
RUN mkdir -p ${CONDA_DIR}

# Install conda
RUN cd /tmp && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-4.0.5-Linux-x86_64.sh && \
    echo "a7bcd0425d8b6688753946b59681572f63c2241aed77bf0ec6de4c5edc5ceeac *Miniconda3-4.0.5-Linux-x86_64.sh" | sha256sum -c - && \
    /bin/bash Miniconda3-4.0.5-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-4.0.5-Linux-x86_64.sh && \
    $CONDA_DIR/bin/conda install --quiet --yes conda==4.0.5 && \
    $CONDA_DIR/bin/conda config --system --add channels conda-forge && \
    conda clean -tipsy


# Install Python 3 packages
RUN conda install --yes \
    'notebook=4.2*' 'ipywidgets=4.1*' 'pandas=0.17*' 'numexpr=2.5*' 'matplotlib=1.5*' \
    'scipy=0.17*' 'seaborn=0.7*' 'scikit-learn=0.17*' 'jsonschema' 'pillow' \
    'pip' 'jpeg=8d' \
    terminado && \
    conda clean -tipsy

# RUN jupyter nbextension enable --py widgetsnbextension --sys-prefix

# Install Python 2 packages
RUN conda create -p $CONDA_DIR/envs/python2 python=2.7 \
    'ipython=4.2*' 'ipywidgets=4.1*' 'pandas=0.17*' 'numexpr=2.5*' \
    'matplotlib=1.5*' 'scipy=0.17*' 'seaborn=0.7*' 'scikit-learn=0.17*' \
    'jsonschema' 'pillow' 'pip' \
    pyzmq && \
    conda clean -tipsy

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
    'r-base=3.2*' 'r-irkernel=0.5*' 'r-plyr=1.8*' 'r-devtools=1.9*' \
    'r-dplyr=0.4*' 'r-ggplot2=1.0*' 'r-tidyr=0.3*' 'r-shiny=0.12*' \
    'r-rmarkdown=0.8*' 'r-forecast=5.8*' 'r-stringr=0.6*' 'r-rsqlite=1.0*' \
    'r-reshape2=1.4*' 'r-nycflights13=0.1*' 'r-caret=6.0*' 'r-rcurl=1.95*' \
    'r-randomforest=4.6*' && \
    conda clean -tipsy

# Create directory where data will be mounted on all workers
ENV DATA_DIR /data
RUN mkdir -p $DATA_DIR
