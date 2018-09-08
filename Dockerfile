FROM python:2.7.15-alpine

ENV SERVER 127.0.0.1
ENV USER us1
ENV PASSWORD 1qazxsw2

COPY /clients /home
WORKDIR /home

CMD ["python", "/home/client-linux.py", "SERVER=$SERVER", "USER=$USER", "PASSWORD=$PASSWORD" ]
