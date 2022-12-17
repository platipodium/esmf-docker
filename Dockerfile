# SPDX-FileCopyrightText: 2022 Helmholtz-Zentrum hereon
# SPDX-License-Identifier: CC0-1.0
# SPDX-FileContributor Carsten Lemmen <carsten.lemmen@hereon.de

FROM ubuntu:latest
LABEL description="ESMF development environment based on Ubuntu"
MAINTAINER Carsten Lemmen <carsten.lemmen@hereon.de>

ARG VERSION="v8.4.0"
ARG COMMUNICATOR="openmpi" # or mpich, this needs to be set via environment

RUN apt update && apt -qy install cmake wget python3 python3-pip \
    python-is-python3 lib${COMMUNICATOR}-dev libmetis-dev libnetcdf-dev \
    libnetcdff-dev git libxerces-c-dev liblapack-dev libyaml-cpp-dev
ENV PATH="/usr/lib64/${COMMUNICATOR}/bin:${PATH}"

ENV ESMF_DIR=/usr/src/esmf

WORKDIR /usr/src
RUN git clone  --branch ${VERSION} --depth 1 https://github.com/esmf-org/esmf.git ${ESMF_DIR}

WORKDIR ${ESMF_DIR}

# Install ESMF
ENV ESMF_COMM=${COMMUNICATOR}
ENV ESMF_COMPILER="gfortran"
ENV ESMF_INSTALL_PREFIX="/usr/local"
ENV ESMF_INSTALL_LIBDIR="/usr/local/lib"
ENV ESMF_INSTALL_MODDIR="/usr/local/mod"
ENV ESMF_INSTALL_BINDIR="/usr/local/bin"
ENV ESMF_INSTALL_DOCDIR="/usr/local/doc"
ENV ESMF_F90COMPILEOPTS="-fallow-argument-mismatch"
ENV ESMF_INSTALL_HEADERDIR="/usr/local/include"
ENV ESMFMKFILE="/usr/local/lib/esmf.mk"
ENV ESMF_ARRAY_LITE="TRUE"

#RUN make -C ${ESMF_DIR} -j8 lib || true
#RUN make -C ${ESMF_DIR} install || true
