FROM jupyter/scipy-notebook:latest

LABEL org.opencontainers.image.authors="Tuple, LLC <contact@tuple.xyz>"

## Environment Settings
ENV DEBIAN_FRONTEND=noninteractive \
    JUPYTER_ENABLE_LAB=yes \
    JUPYTER_TOKEN=equidock \
    NB_USER=equidock \
    CHOWN_HOME=yes \
    GRANT_SUDO=yes \
    RESTARTABLE=yes \
    SETUPTOOLS_USE_DISTUTILS=stdlib

USER root

## Install Basic Dependencies
RUN apt-get update && \
    apt-get -y install git curl wget python3.9 
    #nvidia-cuda-toolkit

## Install EquiDock Dependencies

### CUDA
# RUN sudo apt-get update && \
#     sudo apt-get install -y libassuan0 libnpth0 libksba8 \
#                             dirmngr pinentry \
#                             gpg gpg-agent gpg-wks-client gpg-wks-server gpgsm \
#                             gnupg gnupg-utils && \
#     sudo apt-key adv --fetch-keys  http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub && \
#     sudo bash -c 'echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/cuda.list' && \
#     sudo apt-get update && \
#     sudo apt-get install -y cuda-10-1

### DGL
RUN pip install dgl-cu101 -f https://data.dgl.ai/wheels/repo.html

### RDKit
RUN sudo apt-get update && \
    sudo apt-get install -y librdkit1 rdkit-data
    # python-rdkit

### Python Libraries
COPY ./requirements.txt .
RUN pip install -r requirements.txt

## Download EquiDock
RUN git clone https://github.com/octavian-ganea/equidock_public 
    #&& \ git checkout f0059041d8d3af88a9d120e9e5c36d3bedfb32a8