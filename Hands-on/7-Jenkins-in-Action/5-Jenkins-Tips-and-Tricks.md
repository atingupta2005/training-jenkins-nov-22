# Jenkins Tips and Tricks

## Global environment variables in Jenkins
 - Refer
  - https://wiki.jenkins.io/display/JENKINS/Building+a+software+project#Buildingasoftwareproject-belowJenkinsSetEnvironmentVariables
 - Create a new Jenkins Job and add shell Script
  ```
  echo "Build No: $BUILD_NUMBER"
  echo "Build ID: $BUILD_ID"
  echo "Build URL: $BUILD_URL"
  echo "JOB NAME: $JOB_NAME"
  ```
 - Build the Job and Inspect Console Output

## Create custom global environment variables
 - Open Manage Jenkins\Configure System
 - Scroll Down and refer section - Global Properties
 - Enable - Environment Variables
 - Click Add
  - Specify variable details - G_NAME
 - Save
 - Create new job named - "Project-Env"
 - Create shell script code
```
echo $G_NAME
```
 - Build the job and inspect Console Output

## Learn how to trigger Jobs from external sources: Create a generic user
 - Open Manage Jenkins\Manage Users
 - Create a new user named - jenkins
 - Open Manage Jenkins\Manage and Assign Roles\Manage Roles
 - Create role named - trigger-jobs
  - Assign Permission in the table
    - Overall\Read
    - Job\Build
    - Job\Read
 - Open Manage Jenkins\Manage and Assign Roles\Assign Roles
  - Add user in text box - jenkins
  - In the table above give role to the user - trigger-jobs
 - Login using the user - jenkins
 - Confirm what all actions user can do


## Troubleshooting: Githooks throwing 403 forbidden errors?
- There's a chance your githooks won't trigger correctly with 403 erros
- This is due to a jenkins major upgrade, which modified something called CSRF in Jenkins, that protects you against DOS attacks
- More Info:
 - https://jenkins.io/doc/upgrade-guide/2.176/#SECURITY-626
- Resolution:
 - Install a plugin named Strict Crumb Issue
 - Go to Manage Jenkins -> Configure Global Security -> CSRF Protection
 - Select Strict Crumb Issuer
 - Click on Advanced
 - Uncheck the Check the session ID box
 - Save it


## Trigger Jobs from Bash Scripts (No parameters)
 - Refer Resourses\crumb.sh
 - Right mouse click on Build and copy the link
 - Run first command to collect crumb token on the Jenkins machine terminal
 - Run second command after replacing the URL with the one copied
 - Make sure build has started in Jenkins Portal

## Trigger Jobs from Bash Scripts (With Parameters)
 - Refer Resourses\crumb.sh
 - Run second command after replacing the URL with the one copied and also replace parameter names
 - Make sure build has started in Jenkins Portal
