# Distributed Builds on Jenkins

## Add slave nodes to Jenkins
 -  There are two ways of authentication for setting up the Jenkins slaves.
    -  Using username and password
    -  Using ssh keys.
 -  Jenkins Slave Prerequisites
    - Java should be installed on your slave machine.
    - We should have a valid user id on slave machine using which we can perform the required tasks

## Create a Ubuntu Machine
- Install Docker
```
cd
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
```
- Run Docker container
```
sudo docker run -dit --name my_jenkins_slave --privileged=true -p 8889:8080 -p 222:22 atingupta2005/tomcat_jenkins_ubuntu
sudo docker exec -it my_jenkins_slave service ssh start
```

## Setting Up Oracle and Maven on Slave
- Login to Docker container at port 222
- If required switch to root:
```
ssh root@localhost -p 222 	# password 123456
apt  -y update
```
- Install Maven
```
apt install -y openjdk-8-jdk
apt install -y maven
```

- Check if Java and maven are installed?
```
java -version
mvn -v
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
Advanced Settings - Port: 222
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
ssh jenkins@localhost -p 222
```


## Setting up Jenkins slaves using ssh keys
- Create another docker container
```
sudo docker run -dit --name my_jenkins_slave_ssh --privileged=true -p 8890:8080 -p 223:22 atingupta2005/tomcat_jenkins_ubuntu
sudo docker exec -it my_jenkins_slave_ssh service ssh start

ssh root@localhost -p 223 	# password 123456
apt  -y update
apt install -y openjdk-8-jdk
apt install -y maven
java -version
mvn -v
adduser jenkins --shell /bin/bash
su jenkins
mkdir /home/jenkins/jenkins_slave
exit
```

- Login to the slave server as a jenkins user.
```
ssh jenkins@localhost -p 223
```

- Check if SSH keys exists:
```
cd ~/.ssh
ls ~/.ssh
```

- Create a .ssh directory and cd into the directory
- Only create if not exist
```
mkdir ~/.ssh && cd ~/.ssh
```

- Create an ssh key pair using the following command. Press enter for all the defaults when prompted.
```
ssh-keygen -t rsa -C "The access key for Jenkins slaves "
```

- Add the public to authorized_keys file using the following command.
```
cat id_rsa.pub > ~/.ssh/authorized_keys
```

- Now, copy the contents of the private key to the clipboard.
```
cat id_rsa
```

## Add the private key to Jenkins credential list
- Go to jenkins - Dashboard -> manage jenkins -> manage credentials -> Global credentials -> add credentials
- Select and enter all the credentials as shown:
```
ID: jenkins_ssh
Kind: SSH username with private key
Preivate Key: Enter directly
```
- Paste the private key
- Save



- Now create a new Slave Node in jenkins and connect:
```
```
# of executers: 2
```
Remote root directory: /home/jenkins/jenkins_slave
Labels: ubuntu_slave2
Usage: Only build jobs with label expressions matching this node
Launch method: Launch agents via SSH
Host: localhost
Credentials: select ssh private key
Host Key Verification Strategy: Non verifying Verification Strategy
Advanced Settings - Port: 223
```

## Test the slaves
- To test the slave, create a sample project and select the option as shown
- You need to select the node using the label option
- If you start to type the letter the node list will show up - node2
