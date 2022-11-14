# Jenkins and Docker
 - Learn how to execute job on remote machine

## Docker + Jenkins + SSH
 - Clone Project
```
git clone https://github.com/atingupta2005/Jenkins-5-Days-Training-Material
```
 - Create a Docker container
  - Refer:
    - ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources
  - Copy below 4 files from the directory Dockerfile-CentOS-SSH to ~/jenkins-data
    - docker-compose.yml
    - Dockerfile
    - remote-key
    - remote-key.pub

```
cd ~/Jenkins-5-Days-Training-Material/Hands-On/7-Jenkins-in-Action/Resources/Dockerfile-CentOS-SSH
cp * ~/jenkins-data
cd ~/jenkins-data
chmod 400 remote-key
docker-compose build
docker-compose up -d
docker ps
docker inspect remote-host
ssh -i remote-key remote_user@ip-of-remote-host
  # Password: 1234

exit
docker cp remote-key jenkins:/tmp/remote-key
docker exec -it -u root jenkins bash
ls /tmp/
chmod 400 /tmp/remote-key
ssh -i /tmp/remote-key remote_user@remote-host
exit
```

## Install SSH Plugin in Jenkins
 - Open Manage Jenkins\Manage Plugins
 - Open Available tab
 - Search SSH and install SSH Plugin
 - Install without restart
 - Enable checkbox - Restart

## Integrate Docker Container using SSH Server with Jenkins
 - Open Manage Jenkins\Configure System
 - Scroll down
 - In section - "SSH Remote hosts" click Add
 - specify details
  - To add credentials (Optional) - Manage Jenkins\Credentials\Jenkins\Global Credentials\Add Credentials
    - Type: SSH Username with Private Key
    - Enter private key text from remote-key available in "Resources\Dockerfile-CentOS-SSH"
  - Test connection


## Run your Jenkins Job on your Docker container though SSH
- Create new Job named - "Day1-Remote-task"
- Build section\Execute shell-script on remote host using SSH
- Command
  ```
  NAME=Atin
  echo "Hello, $Name. Current date and time is $(date)" > /tmp/remote-file.txt
  cat /tmp/remote-file.txt
  ```
- Build the Job
- Verify file is created in container - remote-host
```
docker exec -it remote-host bash
cat /tmp/remote-file.txt
```
