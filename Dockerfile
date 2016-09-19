FROM debian:8
MAINTAINER Martin Diederich <martin.diederich@gmail.com>

# set env vars
ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

# configure apt sources
RUN echo "deb http://security.debian.org/ jessie/updates main contrib non-free \n\
deb http://ftp.de.debian.org/debian jessie main contrib non-free \n\
deb http://ftp.de.debian.org/debian jessie-updates main contrib non-free \n\
deb http://ftp.de.debian.org/debian jessie-backports main" > /etc/apt/sources.list

# configure apt behaviour
RUN echo "APT::Get::Install-Recommends 'false'; \n\
APT::Get::Install-Suggests 'false'; \n\
APT::Get::Assume-Yes "true"; \n\
APT::Get::force-yes "true";" > /etc/apt/apt.conf.d/00-general

# install
RUN apt-get update
RUN apt-get install -y apt-utils

# install typical requirements for testing
RUN apt-get install -y procps ssl-cert ca-certificates apt-transport-https python sudo curl

# install goss
RUN curl -L https://github.com/aelsabbahy/goss/releases/download/v0.2.3/goss-linux-amd64 -o /usr/local/bin/goss
RUN chmod +rx /usr/local/bin/goss

# cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
