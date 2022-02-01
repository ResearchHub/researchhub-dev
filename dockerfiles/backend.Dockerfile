FROM python:3.6.12-alpine


RUN apk add gcc g++ cmake make mupdf-dev freetype-dev git libxml2-dev \
        libxslt-dev postgresql postgresql-dev musl-dev libffi-dev libpng-dev \
        jpeg-dev libjpeg-turbo-dev openjdk11 bash

ARG MUPDF=1.18.0
RUN ln -s /usr/include/freetype2/ft2build.h /usr/include/ft2build.h \
    && ln -s /usr/include/freetype2/freetype/ /usr/include/freetype \
    && wget -c -q https://www.mupdf.com/downloads/archive/mupdf-${MUPDF}-source.tar.gz \
    && tar xf mupdf-${MUPDF}-source.tar.gz \
    && cd mupdf-${MUPDF}-source \
    && make HAVE_X11=no HAVE_GLUT=no shared=yes prefix=/usr/local install \
    && cd .. \
    && rm -rf *.tar.gz mupdf-${MUPDF}-source

RUN pip install PyMuPDF==1.18.8

COPY ./requirements.dev.txt /researchhub-backend/src/requirements.txt

WORKDIR /researchhub-backend/src/

RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN python -m pip check

ENV SIFT_REST_API_KEY='null'
ENV APP_ENV='development'
ENV RUN_RESEARCHHUB_DEV_SUBDOMAIN=true
ENV VIRTUAL_HOST=dev-backend.researchhub.com