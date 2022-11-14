# Integrating GitHub with Jenkins

- Install GitHub plugin in Jenkins (If not already installed)
  - Go to Manage Jenkins -> Manage Plugin
  - Search 'GitHub plugin' in the Installed tab. If its there then no need to install it
  - Search 'GitHub Plugin' in the Available tab then click on Download now and install after the restart

- Install Maven Plugin
  - Go to Jenkins- Manage Plugins
    - Install - 'Maven Integration'

- Install Maven
  - Login to Jenkins Server console
  - Install maven

```
sudo apt install -y maven
mvn -v
```

- Integrate Jenkins with GitHub

- Go to Manage Jenkins\\Configure System - Go to GitHub section

- Go to [GitHub Repository](https://github.com/atingupta2005/simple-java-maven-app) - click on settings- Go to webhook and click Add Webhook

- In the ‘Payload URL’ field, paste your Jenkins environment URL

- At the end of this URL add /github-webhook/
  - http://vmubuntu-terraform-jenkins-aws.eastus.cloudapp.azure.com:8080/github-webhook/

- In the ‘Content type’ select: ‘application/json’ and leave the ‘Secret’ field empty.

- In the page ‘Which events would you like to trigger this webhook?’ choose ‘Let me select individual events.’

- Then, check ‘Pull Requests’ and ‘Pushes’

- At the end of this option, make sure that the ‘Active’ option is checked and click on ‘Add webhook’.

- Creating a Jenkins job
  - Create a new task for Jenkins, click on “New Item”
  - Under the Source Code Management tab, select Git, and then set the Repository URL to point to your [GitHub Repository](https://github.com/atingupta2005/simple-java-maven-app)
  - Now Under the Build Triggers tab, select the “GitHub hook trigger for GITScm polling’” checkbox.
  - Build\\Invoke top level maven targets
    - Goals: clean package
  - Post Build Actions\\Archive the Artifacts
    - Files to archive: \*\*/\*.jar
