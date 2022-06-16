FROM ubuntu:latest
LABEL description="ESMF development environment based on Ubuntu"
MAINTAINER Carsten Lemmen <carsten.lemmen@hereon.de>

ARG VERSION="v8.3.0"
ARG COMMUNICATOR="openmpi"

RUN apt update && apt -qy install cmake python3 python3-pip python-is-python3 lib${COMMUNICATOR%%3}-dev libmetis-dev libnetcdf-dev libnetcdff-dev git
ENV PATH="/usr/lib64/${COMMUNICATOR}/bin:${PATH}"

WORKDIR /usr/src/
RUN git clone --depth 1 https://git.code.sf.net/p/esmf/esmf

# Install ESMF
ENV ESMF_DIR=/usr/src/esmf
ENV ESMF_COMM=${COMMUNICATOR}
ENV ESMF_COMPILER="gfortran"
ENV ESMF_INSTALL_PREFIX="/usr/local"
ENV ESMF_INSTALL_LIBDIR="/usr/local/lib"
ENV ESMF_INSTALL_MODDIR="/usr/local/mod"
ENV ESMF_INSTALL_BINDIR="/usr/local/bin"
ENV ESMF_INSTALL_DOCDIR="/usr/local/doc"
ENV ESMFMKFILE="/usr/local/lib/esmf.mk"
ENV ESMF_ARRAY_LITE="TRUE"

RUN make -C ${ESMF_DIR} -j4 lib
RUN make -C ${ESMF_DIR} install
