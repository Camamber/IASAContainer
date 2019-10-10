FROM ubuntu:latest
LABEL maintainer="Camamber"

#setup basic utilities
RUN apt-get update && apt-get install curl sudo vim certbot -y

#setup nodejs
RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo bash -
RUN apt-get install nodejs -y

#setup nginx
RUN apt-get update
RUN apt-get install nginx -y

#setup php
RUN apt-get update
RUN apt-get install php-fpm php-mysql -y
RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.2/fpm/php.ini

#setup ssh
RUN apt-get install vim openssh-server -y
RUN mkdir /var/run/sshd

#setup web user and sudo user
RUN useradd -m -s /bin/bash web && \
    echo 'web:D7dbZMkgM7PRNe4P' |chpasswd && \
    passwd -e web

RUN useradd -m -s /bin/bash camamber && \
    echo 'camamber:dn86sm3pyx2b4cf2' |chpasswd && \
    usermod -aG sudo camamber && \
    passwd -e camamber

RUN mkdir /root/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22 80

CMD ["/usr/sbin/sshd", "-D"]
