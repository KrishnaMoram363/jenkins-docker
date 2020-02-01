#!/bin/bash
HOST_IP="$(hostname -i)"
echo "HOST_IP: " $HOST_IP
APPNAME="$(basename "$PWD")"
echo "Stop / Remove ... $APPNAME"
docker stop $APPNAME
docker rm $APPNAME
docker rmi $APPNAME
echo "Rebuild ..."
echo "docker build -t $APPNAME . "
docker build -t $APPNAME . 
echo "Rebuild complete."
echo "Startup ..."
CMD="docker run -p 8080:8080 -p 50000:50000 -e "HOST_IP=$HOST_IP" --name=$APPNAME --mount source=jenkins-data,target=/var/jenkins_home -d $APPNAME"
echo $CMD
$CMD
echo "Deployment completed" 
