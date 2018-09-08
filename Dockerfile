FROM phusion/baseimage:0.10.2

ENV SERVER 127.0.0.1
ENV USER us1
ENV PASSWORD 1qazxsw2

WORKDIR /home

RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh
CMD ["/sbin/my_init"]

RUN apt-get update \
    && apt-get install -y python \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && mkdir /etc/service/ServerStatus

COPY /root /

#copy scripts
COPY /runit/ServerStatus.sh /etc/service/ServerStatus/run

#文件权限
RUN chmod u+x /etc/service/ServerStatus/run

