#!/bin/bash
app="fbert"
docker build -t ${app} .
docker run  ${app} -d -p 5000:5000 --name=${app} 