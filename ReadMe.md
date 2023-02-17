<!--
# SPDX-FileCopyrightText: 2022-2023 Helmholtz-Zentrum hereon
# SPDX-License-Identifier: CC0-1.0
# SPDX-FileContributor Carsten Lemmen <carsten.lemmen@hereon.de
-->

# Docker file for ESMF

This repository contains a Dockerfile for building ESMF docker images and continuous 
integration for uploading the Dockerfile to the HZDR registry.  Currently, two images 
are provided via continuous deployment:

- `registry.hzdr.de/mossco/esmf-docker/esmf:v8.4.0-openmpi`
- `registry.hzdr.de/mossco/esmf-docker/esmf:v8.4.0-mpich`

Both images (`openmpi` and `mpich`) are based on `ubuntu/jammy` with a `gfortran-11`
toolchain including `xerces`, `yaml`, `lapack`, `parmetis`, and `netcdf`.

# Usage

You can use the docker image in your own CI project by specifying in your 
`.gitlab-ci.yml` this image, e.g. in the following fashion:

```
default:
    image: registry.hzdr.de/mossco/esmf-docker/esmf:v8.4.0-openmpi
```
