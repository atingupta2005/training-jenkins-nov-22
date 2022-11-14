# Installing Jenkins
## Setup Docker (If required)
- Refer:
  - [Docker Setup Instructions](6-Docker/001-Setup-Docker.md)

## Docker (We will use this option)
- Create Jenkins Home folder which will have jenkins data and the docker-compose.yml file
```
cd ~
mkdir jenkins-data
cd  jenkins-data
mkdir jenkins_home
```
- Create ~/jenkins-data/docker-compose.yml
  - Refer to the file content from ./Resourses/1-Jenkins-Docker/docker-compose.yml
- Build Docker Container
```
docker-compose up -d
docker ps
docker logs -f jenkins
docker exec -it -u root jenkins bash
exit
docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

Browse to http://localhost:8080

## Installing Jenkins on Ubuntu Linux
 - Checking and Installing Java
```
java -version
sudo apt update
sudo apt search openjdk
sudo apt install openjdk-11-jdk
java -version
```

- Add the Jenkins Repository (If required)
```
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
```


- Installing Jenkins
```
sudo apt-get -y update
sudo apt install -y jenkins
systemctl status jenkins
sudo systemctl enable jenkins
```

## Windows
 - Download from
  - https://www.jenkins.io/download/#downloading-jenkins
 - Run the setup
