# Continuous Integration setup - Jenkins and GitHub

## Fork GitHub repo:
 - https://github.com/atingupta2005/hello-world-maven.git

## Configuring GitHub
- Go to your GitHub repository and click on 'Settings'.
- Click on Webhooks and then click on 'Add webhook'.
- In the 'Payload URL' field, paste your Jenkins environment URL.
- At the end of this URL add /github-webhook/
 - Sample: http://13.90.41.2:8080/github-webhook/
- In the 'Content type' select 'application/json' and leave the 'Secret' field empty.
- In the 'Which events would you like to trigger this webhook?' choose 'Let me select individual events.'
- Then, check 'Pull Requests' and 'Pushes'
- At the end of this option, make sure that 'Active' is checked and click on 'Add webhook'.


## Configuring Jenkins
- In Jenkins, click on 'New Item' named - Day 2-CICD-1
- Give your project a name, them choose 'Freestyle project' and finally click on 'OK'.
- Click on the 'Source Code Management' tab.
- Click on Git and paste your forked GitHub repository URL in the 'Repository URL' field.
- Click on the 'Build Triggers' tab and then on the 'GitHub hook trigger for GITScm polling'
- Your GitHub repository is integrated with your Jenkins project.
- Add Build Step - Invoke top-level maven targets
  - Goals: clean package
- Change Source Code in Git Repository and the build will be triggered automatically

## Triggering the Jenkins Job to Run with Every Code Commit
- Go to your GitHub repository, edit the code and commit the changes.
- We will now see how Jenkins ran the script after the commit.
- Go back to your Jenkins project and you'll see that a new job was triggered automatically from the commit we made at the previous step.
- Review 'Console Output'.
- You can see that Jenkins was able to pull the latest code and run it!

- Every time you publish your changes to GitHub, it will trigger your new Jenkins job.


## Code Packaging automation (Optional)
- We will follow below manual steps to understand how mvn can be used to build java project
- Login to Jenkins Server
- Clone
```
cd
git clone https://github.com/atingupta2005/java-servlet-hello
cd java-servlet-hello
```

- Compile app
```
mvn clean install
```

- Package App
```
mvn clean package
```

## Step 1 — Compiling the Source Code
- Let's begin by first creating a Freestyle project in Jenkins
- Use Project Name – "Compile"
- When you scroll down you will find an option to add source code repository, select "git" and add the repository URL
  - https://github.com/atingupta2005/java-servlet-hello
- Now we will add a Build Trigger
- Pick the poll SCM option
 - H/5 * * * *
- Basically, we will configure Jenkins to poll the GitHub repository after every 5 minutes for changes in the code
- In the build tab, click on invoke top level maven targets and type the below command:
```
clean compile
```
  - This will pull source code from the GitHub repository and will also compile it.
- Click on Save and Build Now the project.
- Now, click on the console output to see the result.



## Step 2 — Test the Source Code
- Now we will create one more Freestyle Project for unit testing.
- Project Name - Test
- Add the same repository URL in the source code management tab, like we did in the previous job.
  - https://github.com/atingupta2005/java-servlet-hello
- Now, in the "Build Trigger" tab click on the "Build after other projects are built"
- Select the project - Compile
- In the Build tab, click on invoke top level maven targets and use the below command:
```
test
```

- Again, save it and click on Build Now.


## Step 3 — Creating a JAR File and Deploying
- Create one more freestyle project and add the source code repository URL
- Then in the build trigger tab, select build when other projects are built
- Select the project - Test
- Project Name – "Create Jar"
- In the build tab, select Execute Shell
- Type the below command to package the application:
```
mvn package
```
- Before we can deploy to Tomcat, we need to setup a Tomcat Server.
- For detailed instructions on how to setup Tomcat, please refer to:
  - A-Setup-Tomcat-Server-Run-from-Docker-Image.md

## Step 4 – Configure Jenkins
- Install Jenkins Plugins:
  - Maven Integration
  - Publish over SSH

- Now need to configure SSH server details to connect the Tomcat container

- In Jenkins, go to
 - Dashboard > Manage Jenkins > Configure System and find "SSH Servers"
 - Enter details as shown below:
    - Name: my_tomcat_container
    - Hostname: my_tomcat_container
    - Remote Directory: /root/tomcat
- Click Advanced:
    - Passphrase Password: 123456
    - Port: 22

-  Now test connectivity.

- Note: if any error - "Failed to connect or change directory", then make sure root/tomcat exists in docker container

- Create a new Item -> Freestyle project
  - Project Name:
    - Simple_tomcat_deployment
- Git URL:
    - https://github.com/atingupta2005/java-servlet-hello
- Build:
  - Invoke top level maven targets:
      - package -Dmaven.test.skip=true


## Step 5 — Creating a WAR File and Deploying
- Post Build Actions Tab
- Send Build Artifacts on SSH:
  - Source Files: \*\*/*.war
  - In Exec command field:

```
cp ./tomcat/*.war /opt/apache-tomcat-8.5.58/webapps
/opt/apache-tomcat-8.5.58/bin/shutdown.sh
/opt/apache-tomcat-8.5.58/bin/startup.sh
```
- Open Advanced and enable the option – "Flatten Files"
- The above will copy all war files to tomcat container in /opt/apache-tomcat-8.5.58/webapps

- Build Now
  - Initiate the build process from the Project’s Jenkins Page, and go to the console log output to see if the build was a success or if there is any error/exception.

- Your build finished with a SUCCESS message.
- Now go to your web browser and open
  - http://your-ip-addr:8888/hello

- You will see your application index page content


## Add slave nodes to Jenkins
### Create a Ubuntu Machine
- There are two ways of authentication for setting up the Jenkins slaves.
  - Using username and password
  - Using SSH keys

- Jenkins Slave Prerequisites
  - Java should be installed on your slave machine.
  - We should have a valid user id on slave machine using which we can perform the required tasks


- Create a Ubuntu Machine
```
sudo docker run -dit --name my_jenkins_slave --privileged=true -p 8889:8080 -p 222:22 --network jenkins-data_net atingupta2005/tomcat_jenkins_ubuntu
sudo docker exec -it my_jenkins_slave bash
# service ssh start
exit
ssh root@localhost -p 222	# password 123456
```

### Setting Up Oracle and Maven on Slave
- If required switch to root:
```
ssh root@localhost -p 222	# password 123456
# Check if Java and maven are already installed?
java -version
mvn -v
```
- Only if needed
```
apt install -y maven
apt install -y openjdk-8-jdk
```

### Create a Jenkins User in Docker Container Slave
- It is recommended to execute all Jenkins jobs as jenkins user on the slave nodes.
- Create a jenkins user and a password using the following command.
```
adduser jenkins --shell /bin/bash
# Password 123456
```

- Now, login as jenkins user.
```
su jenkins		# Password 123456
cd
```

- Create a "jenkins_slave" directory under /home/jenkins.
```
mkdir ~/jenkins_slave
```

## Setting up Jenkins slaves using username/password
- Head over to Jenkins dashboard -> Manage Jenkins -> Manage Nodes and Clouds
- Select new node option.
- Give it a name, select the "permanent agent" option and click ok.
- Add Credentials
 - Add credentials using Manage Credentials in Jenkins
  - Go to jenkins dashboard -> manage jenkins -> manage credentials -> Global credentials -> add credentials

- Fill the options as below:
```
# of executors: 2
Remote root directory: /home/jenkins/jenkins_slave
Labels: ubuntu_slave1
Usage: Only build jobs with .........
Launch method: Launch agents via SSH
Host: my_jenkins_slave
Credentials: jenkins/****
Host Key Verification Strategy: Non verifying verification strategy
```

- Click on Save


### Preparing Slave Nodes to Perform Build
- Create a new Free Style Project named - project-slave-node-1
- Enable - General\"Restrict where the project can be run"

### Setting up Jenkins slaves using SSH keys
- Create a new Docker Container
```
sudo docker run -dit --name my_jenkins_slave_2 --privileged=true -p 8890:8080 -p 223:22 --network jenkins-data_net atingupta2005/tomcat_jenkins_ubuntu
```
- Login to the slave server as a jenkins user
```
ssh jenkins@localhost -p 223
```
- On Docker Container Slave, Create a .ssh directory and cd into the directory
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

### Add the private key to Jenkins credential list
- Go to jenkins dashboard -> manage jenkins -> manage credentials -> Global credentials -> add credentials
- Select and enter all the credentials and click ok.
```
 Kind: SSH Username with private key
 Scope: Global
 Username: jenkins
 Private Key: Enter Directly
```

### Setup slaves from Jenkins master
- Follow the first 3 steps we did for slave configuration using username and password.
- Follow all the configuration in the 4th step. But this time, for the launch method, select the credential you created with the SSH key.


### Test the slaves
- To test the slave, create a sample project and select the option
	- Restrict where the project can be run
- You need to select the node using the label option
- If you start to type the letter, the node list will show up
