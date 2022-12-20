# SPDX-FileCopyrightText: 2022 Helmholtz-Zentrum Hereon
# SPDX-License-Identifier: CC0-1.0
# SPDX-FileContributor Carsten Lemmen <carsten.lemmen@hereon.de

FROM phusion/baseimage:jammy-1.0.1

LABEL description="ESMF development environment based on Ubuntu"
LABEL author="Carsten Lemmen <carsten.lemmen@hereon.de>"
LABEL license="CC0-1.0"
LABEL copyright="2022 Helmholtz-Zentrum Hereon"

# Arguments can be passed via the --build-arg key=value command to the 
# docker build command.  The default values are set below to openmpi, v8.4.0
ARG VERSION="v8.4.0"
ARG COMMUNICATOR="openmpi"
 
RUN apt-get update && apt-get -qy install lib${COMMUNICATOR}-dev \
    cmake wget python3 python3-pip \
    python-is-python3 libmetis-dev libnetcdf-dev \
    libnetcdff-dev libxerces-c-dev liblapack-dev libyaml-cpp-dev \
    libparmetis-dev subversion cvs git

#RUN test `update-alternatives --get-selections |grep -c ${COMMUNICATOR}`
RUN update-alternatives --get-selections |grep -c ${COMMUNICATOR}

#RUN apt-get remove -qy libopenmpi-dev libmpich-dev
#RUN apt-get install -qy libopenmpi-dev lib${COMMUNICATOR}-dev

ENV PATH="/usr/lib64/${COMMUNICATOR}/bin:${PATH}"

ENV ESMF_DIR=/usr/src/esmf

WORKDIR /usr/src
RUN git clone  --branch ${VERSION} --depth 1 https://github.com/esmf-org/esmf.git ${ESMF_DIR}

WORKDIR ${ESMF_DIR}

ENV ESMF_COMM=${COMMUNICATOR}
ENV ESMF_COMPILER="gfortran"
ENV ESMF_INSTALL_PREFIX="/usr/local"
ENV ESMF_INSTALL_LIBDIR="/usr/local/lib"
ENV ESMF_INSTALL_MODDIR="/usr/local/mod"
ENV ESMF_INSTALL_BINDIR="/usr/local/bin"
ENV ESMF_INSTALL_DOCDIR="/usr/local/doc"
ENV ESMF_F90COMPILEOPTS="-fallow-argument-mismatch"
ENV ESMF_INSTALL_HEADERDIR="/usr/local/include"
ENV ESMF_ARRAY_LITE="TRUE"
ENV ESMF_NETCDF="nc-config"
ENV ESMF_XERCES="standard"
ENV ESMF_LAPACK="internal"
ENV ESMF_XERCES="standard"
ENV ESMF_YAMLCPP="internal"
ENV ESMF_PIO="internal"
ENV ESMF_MOAB="internal"
ENV ESMF_ABI=64

ENV ESMFMKFILE="/usr/local/lib/esmf.mk"

RUN make -C ${ESMF_DIR} -j8 lib || true
RUN make -C ${ESMF_DIR} install || true
