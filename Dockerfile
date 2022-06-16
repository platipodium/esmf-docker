ARG VERSION

FROM python:${VERSION}

MAINTAINER Tobias Huste <t.huste@hzdr.de>

RUN pip install --upgrade pip \
    && pip install poetry
