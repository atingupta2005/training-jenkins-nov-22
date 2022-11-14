# Using Jenkins

## Configuring credentials

### Adding new global credentials

 - From the Jenkins home page (i.e. the Dashboard of the Jenkins classic UI), click Manage Jenkins > Manage Credentials
 - Click (global)
 - Click Add Credentials on the left.
 - From the Kind field, choose the type of credentials to add.

## View System Information
 - Manage Jenkins\System Information

## Configure the default port of the Jenkins build server
  - The default port number can be changed in the config file at
 ```
 sudo vim /etc/default/jenkins
 ```
  - Here you can set a different port number, e.g. HTTP_PORT=8082
  - Now you need to restart Jenkins with
```
service jenkins restart
```

## Setting up a Jenkins job
 - The build of a project is handled via jobs in Jenkins
 - Select New Item. Afterwards, enter a name for the job and select Freestyle project and press OK.
 - To retrieve the source code from GitHub, enter the URL to the repository
  - https://github.com/atingupta2005/simple-java-maven-app.git
 - Specify when and how your build should be triggered.
  - Poll SCM (Every 15 Min)
```
H/15 * * * *
```
 - Add a build step in the Build section - Shell Script
```
    - echo "Hello World"
```
 - Press Save to finish the job definition. Press Build Now
