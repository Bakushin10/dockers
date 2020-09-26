# docker run -t -d django-apache2-docker_django-apache2
# docker exec -it  bash

FROM python:3.7-slim
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    apt-utils \
    vim \
    nano \
    curl \
    apache2 \
    apache2-utils

RUN apt-get -y install \
    libapache2-mod-wsgi-py3

#
# COPY the file 
#
RUN mkdir src
COPY ./src /src
COPY ./demo_site.conf /etc/apache2/sites-available/000-default.conf
COPY ./requirements.txt requirements.txt
COPY ./www /var/www/html/django_demo_app
COPY ./angular/dist/ng7 /var/www/html/dist
RUN pip install -r requirements.txt


#
# create /src and change WSGI path to stc
#
# RUN rm /var/www/html/index.html
# RUN chmod -R 777 /var/www/html/dist/index.html
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
