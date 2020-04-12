FROM centos:7

RUN yum -y --enablerepo=extras install epel-release && yum clean all && yum -y update
RUN yum install -y \
        yum-utils \
        curl \
        git \
        rlwrap \
        screen \
        vim \
        gcc \
        nano \
        wget \
        openssl-devel \
        bzip2-devel \
        emacs-nox && \
    yum install -y \
        epel-release && \
    yum groupinstall -y "Development Tools" && \
    yum install -y \
        libffi-devel \
        libxml2-devel \
        libxslt-devel \
        sqlite-devel \
        libsqlite3-dev

#RUN ./configure --enable-loadable-sqlite-extensions && make && sudo make install

RUN yum clean -y all

# install nodejs version 10
RUN curl -sL https://rpm.nodesource.com/setup_10.x | bash - && \
    yum install -y nodejs

# install python 3.7.2
RUN wget https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tgz && \
    tar xzf Python-3.7.2.tgz && \
    cd Python-3.7.2/
RUN  ./Python-3.7.2/configure --enable-optimizations
RUN  make altinstall && \
    rm -f /root/Python-3.7.0.tgz


# # set python3.7 as default
RUN alternatives --install /usr/bin/python python /usr/bin/python2 50
RUN alternatives --install /usr/bin/python python /usr/bin/python3.7 70
RUN alternatives --set python /usr/bin/python3.7

# # symlink pip
RUN ln -s /usr/bin/python3/bin/pip3.7 /usr/bin/pip
RUN pip3 install --upgrade pip pipenv setuptools wheel
RUN ln -s /usr/bin/python3/bin/pipenv /usr/bin/pipenv

# set the locale
RUN localedef --quiet -c -i en_US -f UTF-8 en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV PYTHONUNBUFFERED 1

# copy the file to src/service
RUN mkdir /src
WORKDIR /src
RUN mkdir service
WORKDIR service
COPY . /src/service/

# install python dependency
RUN pip3 install pipenv && \
    pipenv sync
    #pip3 install -r requirements.txt