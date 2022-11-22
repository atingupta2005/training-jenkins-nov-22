# Distributed Builds on Jenkins

## Create a Ubuntu Machine
- Install Docker
```
cd
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
```
- Run Docker container
```
sudo docker run -dit --name my_jenkins_slave_1 --privileged=true -p 8889:8080 -p 2221:22 atingupta2005/tomcat_jenkins_ubuntu
sudo docker exec -it my_jenkins_slave_1 service ssh start
```

```
sudo docker run -dit --name my_jenkins_slave_2 --privileged=true -p 8890:8080 -p 2222:22 atingupta2005/tomcat_jenkins_ubuntu
sudo docker exec -it my_jenkins_slave_2 service ssh start
```


## Setting Up Java on Slave
- Login to Docker container at port 222
- If required switch to root:
```
ssh root@localhost -p 2221 	# password 123456
apt  -y update
```
- Install Java
```
apt install -y openjdk-8-jdk
java -version
exit
```

```
ssh root@localhost -p 2222 	# password 123456
apt  -y update
```
- Install Java
```
apt install -y openjdk-8-jdk
java -version
exit
```

## Create a Jenkins User
- It is recommended to execute all Jenkins jobs as jenkins user on the slave nodes.
- On Docker Container Slave, create a jenkins user and a password using the following command.
```
adduser jenkins --shell /bin/bash
```

- Now, login as jenkins user.
```
su jenkins
```

- Create a “jenkins_slave” directory under /home/jenkins.
```
mkdir /home/jenkins/jenkins_slave
```

## Setting up Jenkins slaves using username/password
- Head over to Jenkins dashboard -> Manage Jenkins -> Manage Nodes
- Select new node option
- Give it a name, select the “permanent agent” option and click ok.
- Enter the details as below and save it
```
# of executers: 2
Remote root directory: /home/jenkins/jenkins_slave
Labels: ubuntu_slave1
Usage: Only build jobs with label expressions matching this node
Launch method: Launch agents via SSH
Host: localhost
Credentials: Add credentials
Host Key Verification Strategy: Non verifying Verification Strategy
Advanced Settings - Port: 2221
```
- Click on Save


## Preparing Slave Nodes to Perform Build
- Create a new Jenkins project and enable property - Restrict where this project can be run
  - Label Expression: ubuntu_slave1

## Build Jenkins Project
- Build the Jenkins project and it should run properly

## Troubleshooting slave agent
- Incorrect Password
- Incorrect port
- Connect using host system to validate:
```
ssh jenkins@localhost -p 2221
```
