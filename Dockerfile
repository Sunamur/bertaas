FROM ubuntu:20.10
RUN apt-get update
RUN apt-get install -y python3 python3-dev python3-pip nginx
RUN pip3 install uwsgi
COPY ./ ./app/
RUN chmod 777 ./app/
WORKDIR ./app/
EXPOSE 5000
ENV FLASK_APP=app_clf.py
RUN pip3 install -r requirements.txt
ENTRYPOINT ["flask"]
CMD ["run", "--host", "0.0.0.0", "-p", "5000"]
