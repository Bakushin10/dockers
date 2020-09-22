# docker run -t -d django-apache
# or
# docker run -d python-centos sleep infinity for centOS
# /src/data_tracker/wsgi.py
#
FROM python:3.6

RUN apt-get update && apt-get install -y \
	nano \
	vim \
	curl \
	apache2 \
	apache2-utils \
	apache2-dev \
	libapache2-mod-wsgi-py3 \
	net-tools

#ENV PYTHONUNBUFFERED 1
RUN pip install \
	virtualenv \
	mod-wsgi

###
### create venv, copy source file and install dependencies from requirements.txt
### https://pythonspeed.com/articles/activate-virtualenv-dockerfile/
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


#
# apache setup
# 
ADD django-apache.conf /etc/apache2/sites-available/django-apache.conf
WORKDIR /etc/apache2/sites-available
RUN a2ensite django-apache.conf

#CMD [ "apache2ctl", "-D", "FOREGROUND" ]