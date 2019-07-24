FROM ubuntu:latest
MAINTAINER Camamber

#setup nodejs
RUN apt-get update && apt-get install curl sudo -y
RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
RUN sudo apt-get install nodejs -y

#setup ssh
RUN apt-get install -y sudo openssh-server
RUN mkdir /var/run/sshd

RUN useradd -m -s /bin/bash web
RUN echo 'web:D7dbZMkgM7PRNe4P' |chpasswd
RUN usermod -aG sudo web

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22 80

CMD ["/usr/sbin/sshd", "-D"]
