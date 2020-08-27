FROM openresty/openresty:1.13.6.2-0-centos

RUN cd /etc/yum.repos.d/ \
    && mv CentOS-Base.repo CentOS-Base.repo.bak \
    && curl -o CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo \
    && curl -o epel.repo http://mirrors.aliyun.com/repo/epel-7.repo \
    && yum install -y cronie

COPY lua /usr/local/openresty/nginx/lua
COPY conf /usr/local/openresty/nginx/conf
COPY test /usr/local/openresty/nginx/test
COPY shells/* /usr/local/

ENV BACKEND_PORT 8000
WORKDIR /usr/local/openresty/nginx
ENTRYPOINT ["sh", "/usr/local/start.sh"]
