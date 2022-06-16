FROM python:3.10

MAINTAINER Tobias Huste <t.huste@hzdr.de>

RUN pip install --upgrade pip \
    && pip install poetry
