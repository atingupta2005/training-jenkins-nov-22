# Project: Implement CICD with Jenkins Pipeline Docker and Maven

## Learn how to install Docker inside of a Docker Container
- Docker is currently not installed in jenkins container
```
docker exec -it -u root jenkins bash
docker ps
exit
```
- Let's create a new container having docker in it
- Move inside Resources\pipleline folder
```
cd ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline
```
- Copy Dockerfile and docker-compose.yml to ~/jenkins-data
```
cp Dockerfile-Jenkins-with-docker ~/jenkins-data/
cp Dockerfile-remote-host ~/jenkins-data/
cp docker-compose.yml ~/jenkins-data/
```
- Build Docker image
```
cd ~/jenkins-data
docker-compose build
docker images | grep docker
```
- Booting up Docker-Compose
```
docker-compose up -d
docker exec -it jenkins bash
id
exit
```
- Give permission on docker.sock
```
sudo chown <id>:<id> /var/run/docker.sock
docker exec -it jenkins bash
docker ps
```

## Define the steps for Pipeline
- Steps are already defined
- Let's review the steps in Jenkinsfile
```
cat ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline/Jenkinsfile
```

## Build: Create a Jar for Maven App using Docker
- Refer
  - Resources/pipeline
  - Resources/pipeline/java-app
```
ls -al  ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline
ls -al  ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline/java-app
```
 - Download docker maven image
```
docker pull maven:3-alpine
docker images
```
- Create Maven container
```
cd ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline
docker run --rm -it -v $PWD/java-app:/app -v /root/.m2/:/root/.m2/ -w /app maven:3-alpine sh
```
- Package app manually
```
ls
mvn package
exit
```

- Modify container creation command to build jar
```
cd ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline
docker run --rm -v $PWD/java-app:/app -v /root/.m2/:/root/.m2/ -w /app maven:3-alpine mvn -B -DskipTests clean package
ls java-app/target/
```

## Build: Write a bash script to automate the Jar creation
- Refer Resources/pipeline/jenkins/build/build.sh
```
cat ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline/jenkins/build/build.sh
```
- Move to folder Resources/pipeline
- Modify path of Workspace variable
```
vim ./jenkins/build/mvn.sh
```
- Run command
```
cd ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline
chmod 777 ./jenkins/build/mvn.sh
./jenkins/build/mvn.sh mvn -B -DskipTests clean package
ls java-app/target
```

## Build: Create a Dockerfile and build an image with Jar
- Refer Resources/pipeline/jenkins/build/Dockerfile-java
```
cat ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline/jenkins/build/Dockerfile-java
```
- Move to folder Resources/pipeline/jenkins/build/
```
cd ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline/jenkins/build/
```
- Copy jar file from target directory to Resources/pipeline/jenkins/build/
```
ls ~/java-app/target
cp ~/java-app/target/my-app-1.0-SNAPSHOT.jar .
```
- Build Docker image
```
docker build -f Dockerfile-Java -t test .
docker images
```
- Verify that the image is there in the image we built. For that we need to create a container to check
```
docker run --rm -it test sh
ls /app
exit
```
- Run jar file in the container
```
docker run -d --name test_container test
docker logs -f test_container
docker rm test_container
```

## Build: Create a Docker Compose file to automate the Image build process
- Refer
  - Resources/pipeline/jenkins/build
  - Resources/pipeline/jenkins/build/docker-compose-build.yml
```
cat ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline/jenkins/build/docker-compose-build.yml
```
- Build image using Docker compose
```
cd ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline/jenkins/build/
cat docker-compose-build.yml
export BUILD_TAG=1
docker-compose -f docker-compose-build.yml build
```

## Build: Write a bash script to automate the Docker Image creation process
- Refer:
  - Resources/pipeline/jenkins/build
  - Resources/pipeline/jenkins/build/docker-compose-build.yml
  - Resources/pipeline/jenkins/build/build.sh
```
cat ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline/jenkins/build/docker-compose-build.yml
cat ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline/jenkins/build/build.sh
```
- Move to the Resources/pipeline folder
```
cd ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline/
```
- Run build.sh to Build Image
```
chmod a+x ./jenkins/build/build.sh
cat ./jenkins/build/build.sh
cat ./jenkins/build/Dockerfile-Java
./jenkins/build/build.sh
docker images | grep maven-project
```

## Build: Add scripts to the Jenkinsfile
- Refer:
  - Resources/pipeline/jenkins/build
  - Resources/pipeline/Jenkinsfile
- Refer build stage commands in Jenkinsfile
```
cat Jenkinsfile
```

## Test: Test code using Maven and Docker
- Command to test
```
docker run --rm -v $PWD/java-app:/app -v /root/.m2/:/root/.m2/ -w /app maven:3-alpine mvn test
```

## Test: Create a bash script to automate the test process
- Refer
  - Resources/pipeline/jenkins/test/mvn.sh
- If required, modify path of Workspace variable in mvn.sh
```
vim ./jenkins/test/mvn.sh
```
- Run script for test
```
cat ./jenkins/test/mvn.sh
chmod 777 ./jenkins/test/mvn.sh
./jenkins/test/mvn.sh mvn test
```

## Test: Add test script to Jenkinsfile
- Refer:
  - Resources/pipeline/jenkins/test
  - Resources/pipeline/Jenkinsfile
- In Jenkinsfile, notice the stage - Test having the code to run the tests
```
cat Jenkinsfile
```

## Create a remote machine to deploy containerized app
- Create a new Ubuntu VM
- Install Docker
- Install docker-compose
- To setup Docker and docker-compose, follow step:
  - [Steps to Setup Docker](../6-Docker/001-Setup-Docker.md)
- Create a user in new VM:
```
sudo adduser prod-user
# Password: 1234
```
- Add prod-user to Docker Group
```
sudo usermod -aG docker prod-user
```

- Add prod-user to sudoers Group
```
sudo usermod -aG sudo prod-user
```

- Switch to Jenkins Server
```
docker exec -it -u root jenkins bash
```

- Create a SSH key for New VM
```
ssh-keygen -f /opt/prod
ls /opt/prod
cat /opt/prod
cat /opt/prod.pub
chown jenkins:root /opt/prod
chmod 600 /opt/prod
```
- Switch to new VM and add SSH public key to it
```
su prod-user
cd
mkdir .ssh
chmod 700 .ssh/
vi .ssh/authorized_keys
# Copy content of prod.pub from Jenkins server and paste here
chmod 600 .ssh/authorized_keys
exit
```

- Switch to Jenkins Server
```
docker exec -it -u root jenkins bash
```

- Connect to new VM using SSH key
```
ssh -i /opt/prod prod-user@<ip-of-new-vm>
exit
```

## Push: Create Docker Hub account
- Visit: hub.docker.com and Sign Up
- Activate account by confirming on the email received

## Push: Create a Repository in Docker Hub
- Click Create Repository in Docker Hub portal


## Push: Push/Pull Docker images to Repository
- Access Jenkins Server terminal
```
docker exec -it jenkins bash
```
- Login to Docker in jenkins server terminal, tag and push image
```
docker login
docker images
docker tag maven-project:1 atingupta2005/maven-project:1
docker push atingupta2005/maven-project:1
```
- Verify Repo in Docker Hub Portal

- On prod-vm pull the image
```
docker pull atingupta2005/maven-project:1
```

## Push: Write a bash script to automate the push process
- Refer:
  - Resources/pipeline/jenkins/push/push.sh
- Specify login id in file - Resources/pipeline/jenkins/push/push.sh
- Set environment variables
```
export BUILD_TAG=1
export PASS=<your-docker-login-password>
```
- Run the push script
```
cd ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline
chmod 777 ./jenkins/push/push.sh
./jenkins/push/push.sh
```


## Push: Add push script to Jenkinsfile
- Refer:
  - Resources/pipeline/Jenkinsfile
- Notice the stage - push having the code to push the image


## Deploy: Transfer some variables to the remote machine
- Refer:
  - Resources/pipeline/jenkins/deploy/deploy.sh
  - Resources/pipeline/jenkins/deploy/publish.sh
- Specify PROD_VM_IP in file - Resources/pipeline/jenkins/deploy/deploy.sh
```
vim ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline/jenkins/deploy/deploy.sh
```
- Specify private key path (If Required) in file - Resources/pipeline/jenkins/deploy/deploy.sh for scp command
```
vim ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline/jenkins/deploy/deploy.sh
```
- Specify docker login id in file - Resources/pipeline/jenkins/deploy/publish.sh
```
vim ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline/jenkins/deploy/publish.sh
```

## Deploy: Deploy application on the remote machine manually
- Refer:
  - Resources/pipeline/jenkins/build
- Connect to Jenkins server
```
docker exec -it -u root jenkins bash
ls
```
- Clone GitHub repo on Jenins Server (If Required)
```
git clone https://github.com/atingupta2005/Jenkins-5-Days-Training-Material.git
```
- Move to Resources/pipeline
- Run commands
```
export BUILD_TAG=<any build id>
cd ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline
chmod 777 ./jenkins/build/build.sh
./jenkins/build/build.sh
docker images | grep maven
chmod 777 ./jenkins/push/push.sh
export PASS=<your docker login password>
./jenkins/push/push.sh
```
- Open Docker Hub portal and validate image is pushed or not
- Move to Resources/pipeline/jenkins/deploy
- Run commands
```
cd ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline
chmod 777 ./jenkins/deploy/deploy.sh
./jenkins/deploy/deploy.sh
```
- Connect to prod-vm
- Verify that file is created
```
cat /tmp/.auth
```
- Now let's deploy the Docker Image manually
```
cd
mkdir maven
cd maven
vim docker-compose.yml
version: '3'
services:
  maven:
    image: "atingupta2005/$IMAGE:$TAG"
    container_name: maven-app
export IMAGE=$(sed -n '1p' /tmp/.auth)
export TAG=$(sed -n '2p' /tmp/.auth)
export PASS=$(sed -n '3p' /tmp/.auth)
docker login -u atingupta2005 -p $PASS
docker-compose up -d
docker logs -f maven-app
```

## Deploy: Transfer the deployment script to the remote machine
- Refer:
  - Resources/pipeline/jenkins/deploy/publish.sh
  - Resources/pipeline/jenkins/deploy/deploy.sh
- Specify docker login id in file - Resources/pipeline/jenkins/deploy/publish.sh
- deploy.sh is having commands to transfer publish.sh to prod-vm
- Move to Resources/pipeline
```
cd ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline
```
- Modify deploy.sh to uncomment last few lines
```
vim ./jenkins/deploy/deploy.sh
```
- Run deploy.sh to transfer pusblish.sh and .auth files to prod-vm
```
./jenkins/deploy/deploy.sh
```

## Deploy: Execute the deploy script in the remote machine
 - It's already handled in previous step

## Deploy: Add deploy script to Jenkinsfile
- Refer:
  - Resources/pipeline/Jenkinsfile
- Notice the command in the stage - deploy
```
cat Jenkinsfile
```

## Create/Fork a Git Repository to store scripts and the code for the app
- Refer
  - https://github.com/atingupta2005/pipeline-maven.git
- Fork the Repository
- Copy the URL of the forked Repo. It's needed while creating the Jenkins pipeline next

## Create the Jenkins Pipeline
- Create a Jenkins pipeline named - pipeline-maven
- Project type should be - Pipeline
- In Pipeline configuration
  - From combo box chose - Pipeline script from SCM
  - Specify Repo URL of GitHub project named - pipeline-maven
    - https://github.com/YourGitHubLoginID/pipeline-maven.git
- Save
- Build
- Open shell of Jenkins server
```
docker exec -it jenkins bash
```
- Move to directory
```
cd ~/workspaces/pipeline-maven
````
  - Review the files in this directory
  - Code is downloaded in this directory when we build Jenkins Job

## Modify the path when mounting Docker volumes
- Note the full path of your workspace folder. It should be in this format:
  - /var/jenkins_home/workspace/pipeline-maven
- We might need to modify mvn.sh to Specify the path for environment variable - WORKSPACE
  - Refer - Resources\pipeline\jenkins\build\mvn.sh
  - Refer - Resources\pipeline\jenkins\test\mvn.sh
```
vim ./jenkins/build/mvn.sh
vim ./jenkins/test/mvn.sh
```
- Commit and push the changes done in our GitHub repo - pipeline-maven.git

## Create the Registry Password in Jenkins
- We will create password for Docker registry in Jenkins
- The is PASS environment variable which is being used in our pipeline script but it's not defined anywhere
- So let's create password in Jenkins
- Open Manage Jenkins\Manage Credentials
- Create a new Global Credential
  - Kind: Secret Text
  - Scope: Global
  - Secret: <password-for-docker-hub>
  - ID: registry-pass
- Modify Jenkinsfile to extract password from Jenkins server
  - We have already done this
  - In Jenkinsfile, refer to the section - environment
- Commit and push the changes
  - It's not required as Jenkinsfile is already updated

## Add the private SSH key to the Jenkins container
- We might have saved our Private key to connect to the prod-vm in the host machine
- We need to save it to Jenkins server - /opt/prod
- Run below command from host VM
```
cd
ls -al
docker cp ~/prod jenkins:/opt/prod
```

- Now connect to prod-vm from jenkins server container using the private key
```
ssh -i /opt/prod prod-user@prod-vm
exit
```

## Add post actions to Jenkinsfile to save Archive Artifacts and publish test report
- Refer:
  - Resources/pipeline/Jenkinsfile
```
cd ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/pipeline
cat Jenkinsfile
```
- We have already modified Jenkinsfile to put the post action
- Refer the post action in Build and Text stages of Jenkinsfile

## Execute Pipeline manually
- Open Jenkins Pipeline - pipeline-maven
- Click on Build
- Review Console Output
- Resolve if there are any errors
- If pipeline ran successful
    - Confirm if artifacts are there on pipeline homepage
    - Login to prod-vm and confirm docker container is created there
```
docker images
docker ps -a
docker logs <container-id>
```
- Also review the entire log of Console output in Jenkins last build

## Create a Git Hook to automatically trigger Pipeline
- Now whenever we do code push to github, we need to trigger pipeline automatically
- We have already done that for another repo, follow the same steps on our github repo
  - [Integrate GitHub with Jenkins](../4-Integrating-GitHub-with-Jenkins.md)
- We need to add hook in GitHub repo - pipeline-maven

## Start the CI/CD process by committing new code to Git!
- Do changes in the code in GitHub repo - pipeline-maven
- Notice that pipeline will now trigger automatically
- Verify a new docker container is created in prod-vm
