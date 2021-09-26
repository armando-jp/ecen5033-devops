FROM python:3-alpine3.10

WORKDIR /usr/src/app
COPY pyapp/. /usr/src/app/

RUN pip install -r requirements.txt
CMD [ "python3", "-u" , "server.py"]