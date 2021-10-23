FROM python:3-alpine3.10
WORKDIR /usr/src/app

COPY . /usr/src/app/

ENV SERVER_HOSTNAME=njsapp-svc
ENV SERVER_PORT=80

RUN pip install -r requirements.txt
CMD ["python", "-u", "./client.py"]