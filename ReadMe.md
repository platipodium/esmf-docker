<!--
# SPDX-FileCopyrightText: 2022 Helmholtz-Zentrum hereon
# SPDX-License-Identifier: CC0-1.0
# SPDX-FileContributor Carsten Lemmen <carsten.lemmen@hereon.de
-->

# Docker file for ESMF

This repository contains a Dockerfile for building ESMF docker images and continuous 
integration for uploading the Dockerfile to the HZDR registry

# Usage

You can use the docker image in your own project by specifying in your 
`.gitlab-ci.yml` this image, e.g. in the following fashion:

```
default:
    image: registry.hzdr.de/mossco/esmf-docker/esmf:v8.3.0-openmpi
```

