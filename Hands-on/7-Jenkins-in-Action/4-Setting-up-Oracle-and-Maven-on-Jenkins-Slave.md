# Setting Up Oracle and Maven on Slave (Optional)
 - We have already seen these steps in [3-Continuous-Integration-Setup](3-Continuous-Integration-Setup.md)
 - In case more slave nodes are needed, putting steps to create slave node in this separate file again
## Create a Docker container
```
sudo docker run -dit --name my_jenkins_slave_? --privileged=true -p 88??:8080 -p 22?:22 --network jenkins-data_net atingupta2005/tomcat_jenkins_ubuntu
sudo docker exec -it my_jenkins_slave_? bash
# service ssh start
exit
ssh root@localhost -p 22?	# password 123456
```

- If required switch to root:
```
su
apt  -y update
```

- Check if Java and maven are already installed?
```
java -version
mvn -v

apt install -y maven
apt install -y openjdk-8-jdk
```

- Create a Jenkins User
```
adduser jenkins --shell /bin/bash
```

- Now, login as jenkins user.
```
su Jenkins
```

- Create a "jenkins_slave" directory under /home/jenkins.
```
mkdir /home/jenkins/jenkins_slave
```

- Setting up Jenkins slaves using ssh keys
- Login to the slave server as a jenkins user.
- Create a .ssh directory and cd into the directory.
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
