# docker run -t -d django-apache
# or
# docker run -d python-centos sleep infinity
# /src/data_tracker/wsgi.py
#
# https://pythonspeed.com/articles/activate-virtualenv-dockerfile/
#

FROM python:3.6

RUN apt-get update && apt-get install -y \
	nano \
	vim \
	curl \
	apache2 \
	apache2-utils \
	apache2-dev \
	libapache2-mod-wsgi-py3

#ADD site_config.conf /etc/apache2/sites-available/000-default.conf

ENV PYTHONUNBUFFERED 1

RUN pip install \
	virtualenv \
	mod-wsgi \
	pipenv

###
### create/activate venv, copy source file and install dependencies
###
WORKDIR /
ENV VIRTUAL_ENV=/src/venv/django-app
RUN mkdir src && mkdir src/venv && \
	python3 -m venv $VIRTUAL_ENV && \
	mkdir src/venv/django-app/app
COPY . /src/venv/django-app/app
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

WORKDIR /src/venv/django-app/app
RUN pip install -r requirements.txt

#CMD [ "apache2ctl", "-D", "FOREGROUND" ]