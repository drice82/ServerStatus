# 使用phusion/baseimage作为基础镜像,去构建你自己的镜像,需要下载一个明确的版本,千万不要使用`latest`.
# 查看https://github.com/phusion/baseimage-docker/blob/master/Changelog.md,可用看到版本的列表.
FROM phusion/baseimage:0.10.2

# 设置正确的环境变量.
ENV HOME /root

# 生成SSH keys,baseimage-docker不包含任何的key,所以需要你自己生成.你也可以注释掉这句命令,系统在启动过程中,会生成一个.
#RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# 初始化baseimage-docker系统
CMD ["/sbin/my_init"]

COPY /server /ServerStatus/server
COPY /web /ServerStatus/web
COPY /caddy /caddy



# 这里可以放置你自己需要构建的命令
RUN apt-get update \
    && apt-get -y install gcc g++ make git \
#    && git clone https://github.com/drice82/ServerStatus \
#    && cp -rf /ServerStatus/web/* /usr/share/nginx/html/ \
    && cd /ServerStatus/server \
    && make \
    && pwd && ls -a \
    && curl https://getcaddy.com | bash -s personal \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && mkdir /etc/service/status \
    && mkdir /etc/service/caddy
    
    
#copy scripts
COPY /runit/status.sh /etc/service/status/run
COPY /runit/caddy.sh /etc/service/caddy/run

#文件权限
RUN chmod u+x /etc/service/status/run \
    && chmod u+x /etc/service/caddy/run

WORKDIR /ServerStatus/server
EXPOSE 80 35601
