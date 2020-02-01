FROM python:3.5

ENV PYTHONUNBUFFERED 1
ENV WEBAPP_DIR=/DDGN

RUN mkdir -p /var/log/gunicorn

RUN mkdir $WEBAPP_DIR

WORKDIR $WEBAPP_DIR

#ADD requirements.txt $WEBAPP_DIR
COPY . $WEBAPP_DIR
RUN pip install -r requirements.txt