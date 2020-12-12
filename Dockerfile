FROM ubuntu:20.10
RUN apt-get update
RUN apt-get install -y python3 python3-dev python3-pip nginx
RUN pip3 install uwsgi
COPY ./ ./app/bertaas/
WORKDIR ./app/bertaas/
EXPOSE 5000/tcp
RUN pip3 install -r requirements.txt
ENV FLASK_APP='app_clf.py'
CMD flask run --host 0.0.0.0
