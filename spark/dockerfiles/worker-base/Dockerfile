FROM gurvin/spark-base

MAINTAINER Gurvinder Singh <gurvinder.singh@uninett.no>

RUN apt-get update && apt-get install -yq --no-install-recommends \
    build-essential python-dev ca-certificates bzip2 unzip jq locales less \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Configure environment
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH

# Install conda
RUN cd /tmp && \
    mkdir -p $CONDA_DIR && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-4.1.11-Linux-x86_64.sh && \
    echo "efd6a9362fc6b4085f599a881d20e57de628da8c1a898c08ec82874f3bad41bf *Miniconda3-4.1.11-Linux-x86_64.sh" | sha256sum -c - && \
    /bin/bash Miniconda3-4.1.11-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-4.1.11-Linux-x86_64.sh && \
    $CONDA_DIR/bin/conda install --quiet --yes conda==4.1.11 && \
    $CONDA_DIR/bin/conda config --system --add channels conda-forge && \
    $CONDA_DIR/bin/conda config --system --set auto_update_conda false && \
    conda clean -tipsy

# Temporary workaround for https://github.com/jupyter/docker-stacks/issues/210
# Stick with jpeg 8 to avoid problems with R packages
RUN echo "jpeg 8*" >> /opt/conda/conda-meta/pinned

# Install Python 3 packages
RUN conda install --yes \
    'notebook=4.3*' 'ipywidgets=5.2*' 'pandas=0.19*' 'numexpr=2.6*' 'matplotlib=1.5*' \
    'scipy=0.17*' 'seaborn=0.7*' 'scikit-learn=0.17*' 'scikit-image=0.11*' 'sympy=1.0*' \
    'cython=0.23*' 'patsy=0.4*' 'statsmodels=0.6*' 'cloudpickle=0.1*' 'dill=0.2*' \
    'numba=0.23*' 'bokeh=0.12*' 'sqlalchemy=1.0*' 'hdf5=1.8.17' 'h5py=2.6*' 'jsonschema' \
    'pillow' 'pip' 'jpeg=8d' 'beautifulsoup4=4.5.*' 'xlrd' \
    terminado && \
    conda clean -tipsy

# RUN jupyter nbextension enable --py widgetsnbextension --sys-prefix

# Install Python 2 packages
RUN conda create -p $CONDA_DIR/envs/python2 python=2.7 \
    'notebook=4.3*' 'ipywidgets=5.2*' 'pandas=0.19*' 'numexpr=2.6*' 'matplotlib=1.5*' \
    'scipy=0.17*' 'seaborn=0.7*' 'scikit-learn=0.17*' 'scikit-image=0.11*' 'sympy=1.0*' \
    'cython=0.23*' 'patsy=0.4*' 'statsmodels=0.6*' 'cloudpickle=0.1*' 'dill=0.2*' \
    'numba=0.23*' 'bokeh=0.12*' 'sqlalchemy=1.0*' 'hdf5=1.8.17' 'h5py=2.6*' 'jsonschema' \
    'pillow' 'pip' 'jpeg=8d' 'beautifulsoup4=4.5.*' 'xlrd' \
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
    'r-base=3.3.1 1' 'r-irkernel=0.7*' 'r-plyr=1.8*' 'r-devtools=1.11*' \
    'r-dplyr=0.4*' 'r-ggplot2=2.1*' 'r-tidyr=0.5*' 'r-shiny=0.13*' \
    'r-rmarkdown=0.9*' 'r-forecast=7.1*' 'r-stringr=1.0*' 'r-rsqlite=1.0*' \
    'r-reshape2=1.4*' 'r-nycflights13=0.2*' 'r-caret=6.0*' 'r-rcurl=1.95*' \
    'r-randomforest=4.6*' 'r-crayon=1.3*' && \
    conda clean -tipsy

# Add example datasets
ADD datasets/ /opt/datasets
