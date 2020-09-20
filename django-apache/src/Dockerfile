#
# docker run -t -d python-web-centos
# or
# docker run -d python-centos sleep infinity

#FROM centos:7
FROM centos/python-36-centos7

# default user was set to jboss in centOS 
USER root
RUN yum -y --enablerepo=extras install epel-release && \
	yum clean all && \
	yum -y update && \
	yum install -y \
	curl \
	vim \
	nano \
	openssl-devel \
	# apache 
	httpd

###
### COPY source file
###
WORKDIR /
RUN mkdir src
COPY . src/

#CMD [ "executable" ]