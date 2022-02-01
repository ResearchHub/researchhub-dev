FROM centos:7


RUN yum install -y gcc g++ cmake make mupdf-dev freetype-dev git libxml2-dev \
        libxslt-dev postgresql postgresql-dev musl-dev libffi-dev libpng-dev \
        jpeg-dev libjpeg-turbo-dev openjdk11 openssl-devel wget libpq-dev \
        python3-dev postgresql-libs postgresql-devel python-devel gcc-c++ mupdf






# RUN cd /usr/src
RUN wget https://www.python.org/ftp/python/3.6.12/Python-3.6.12.tar.xz
RUN tar -xvf Python-3.6.12.tar.xz
# RUN cd Python-3.6.12
WORKDIR /Python-3.6.12

RUN ./configure --prefix=/opt/python3

RUN make install
RUN ln -s /opt/python3/bin/python3.6 /usr/bin/python3.6
RUN ln -s /usr/bin/python3.6 /usr/bin/python3



# ARG MUPDF=1.18.0
# RUN ln -s /usr/include/freetype2/ft2build.h /usr/include/ft2build.h \
#     && ln -s /usr/include/freetype2/freetype/ /usr/include/freetype \
#     && wget -c --no-check-certificate https://www.mupdf.com/downloads/archive/mupdf-${MUPDF}-source.tar.gz \
#     && tar xf mupdf-${MUPDF}-source.tar.gz \
#     && cd mupdf-${MUPDF}-source \
#     && make HAVE_X11=no HAVE_GLUT=no shared=yes prefix=/usr/local install \
#     && cd .. \
#     && rm -rf *.tar.gz mupdf-${MUPDF}-source

# RUN python3 -m pip install PyMuPDF==1.18.8



# RUN ln -s /usr/include/freetype2/ft2build.h /usr/include/ft2build.h 
# RUN ln -s /usr/include/freetype2/freetype/ /usr/include/freetype 
# WORKDIR /
# RUN wget -c --no-check-certificate https://www.mupdf.com/downloads/archive/mupdf-1.18.0-source.tar.gz

# RUN tar xf mupdf-1.18.0-source.tar.gz 
# WORKDIR /mupdf-1.18.0-source 
# RUN make HAVE_X11=no HAVE_GLUT=no shared=yes prefix=/usr/local install 
# RUN wget 
# RUN rpm -Uvh psychotic-release*rpm
# RUN yum localinstall http://packages.psychotic.ninja/7/testing/x86_64/RPMS/mupdf-devel-1.18.0-6.el7.psychotic.x86_64.rpm

RUN wget --no-check-certificate https://mupdf.com/downloads/archive/mupdf-1.18.0-source.tar.gz
RUN tar -zxvf mupdf-1.18.0-source.tar.gz


ENV CFLAGS="-fPIC -std=gnu99"
WORKDIR  /mupdf-1.18.0-source
# RUN make HAVE_X11=no HAVE_GLFW=no HAVE_GLUT=no HAVE_LEPTONICA=yes HAVE_TESSERACT=yes prefix=/usr/local
RUN make HAVE_X11=no HAVE_GLFW=no HAVE_GLUT=no HAVE_LEPTONICA=no HAVE_TESSERACT=no prefix=/usr/local install

WORKDIR /
RUN rm -rf PyMuPDF
RUN git clone https://github.com/pymupdf/PyMuPDF.git
WORKDIR /PyMuPDF

RUN python3 setup.py build
RUN python3 setup.py install

# RUN python3 -m pip install PyMuPDF==1.18.8



# RUN git clone -b connerdev https://github.com/ResearchHub/researchhub-backend.git

COPY requirements.dev.txt /researchhub-backend/src/requirements.txt

# RUN cp -R /researchhub-backend/src/config/* /researchhub-backend/src/config_local/

WORKDIR /researchhub-backend/src/

# RUN pip install --upgrade pip
# RUN pip install -r requirements.txt
# RUN python -m pip check

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install -r requirements.txt
RUN python3 -m python -m pip check

ENV SIFT_REST_API_KEY='null'
ENV APP_ENV='development'
ENV RUN_RESEARCHHUB_DEV_SUBDOMAIN=true
ENV VIRTUAL_HOST=dev-backend.researchhub.com