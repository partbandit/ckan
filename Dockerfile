FROM debian:jessie
# Install required system packages
RUN apt-get -q -y update \
    && DEBIAN_FRONTEND=noninteractive apt-get -q -y upgrade \
    && apt-get -q -y install \
        python-dev \
        python-pip \
        python-virtualenv \
        python-wheel \
        libpq-dev \
        libxml2-dev \
        libxslt-dev \
        libgeos-dev \
        libssl-dev \
        libffi-dev \
        postgresql-client \
        build-essential \
        git-core \
        vim \
        wget \
    && apt-get -q clean \
    && rm -rf /var/lib/apt/lists/*
COPY . /ckan-2.8.2-theme
WORKDIR /ckan-2.8.2-theme 
RUN virtualenv env \
    && env/bin/pip install -r requirements.txt \
    && env/bin/python setup.py develop
RUN cd ckan-dataportaltheme/ \
    && /ckan-2.8.2-theme/env/bin/python setup.py develop
RUN cd .. \
    && cp ckan/config/who.ini who.ini
EXPOSE 5002
CMD ["env/bin/paster","serve","production.ini"]