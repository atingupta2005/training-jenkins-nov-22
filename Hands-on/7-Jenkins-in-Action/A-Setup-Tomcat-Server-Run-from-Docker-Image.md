# Setup-Tomcat-Server-Run from Docker Image

## Pre-requisite for deployment to Tomcat
```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
```

- Make sure to enable ports 8888 and 221 on Azure portal in Incoming Ports


## Setup Tomcat Server
```
sudo docker run -dit --name my_tomcat_container --privileged=true -p 8888:8080 -p 221:22 --network jenkins-data_net atingupta2005/tomcat_jenkins_ubuntu
sudo docker exec -it my_tomcat_container bash
# service ssh start
# /opt/apache-tomcat-8.5.58/bin/startup.sh
# exit
exit
ssh root@localhost -p 221	# password 123456
mkdir tomcat
```

## ----(Only if needed)

- Run Docker Tomcat Container
```
sudo docker container start my_tomcat_container
sudo docker exec -it my_tomcat_container bash
# service ssh start
# /opt/apache-tomcat-8.5.58/bin/startup.sh
# exit
ssh atin@localhost -p 221	# password 123456
# exit
ssh root@localhost -p 221	# password 123456
```
