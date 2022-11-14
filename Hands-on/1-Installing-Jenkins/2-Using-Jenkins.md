# Using Jenkins

## View System Information
 - Manage Jenkins/System Information

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
