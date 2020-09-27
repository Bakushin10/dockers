# docker run -t -d angular-django-apache_django-api
# docker exec -it  bash

FROM python:3.7-slim
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
	# apt-utils \
	# vim \
	# curl \
	# apache2 \
	# apache2-utils \
	libpq-dev \
	python3-dev \
	gcc \
	libapache2-mod-wsgi-py3 \
	nano

COPY . /django
WORKDIR /django
RUN pip install -r requirements.txt

#CMD ["python", "manage.py", "runserver"]
