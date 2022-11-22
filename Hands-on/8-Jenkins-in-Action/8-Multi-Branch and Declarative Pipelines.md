# Multi-Branch and Declarative Pipelines

## Global Variables
 - A global variable is accessible in any scope within our program
 - There are pre-defined global variables. Examples:
    - BRANCH_NAME
    - BUILD_NUMBER
    - BUILD_ID
    - JOB_NAME
    - NODE_NAME
    - JENKINS_HOME
    - BUILD_URL

## Create Multibranch project
-  Create a new project on Jenkins and, under the Project type, select Multibranch pipeline and enter an appropriate name for the project.
-  Under Branch Sources, select Add source and select GitHub
    - https://github.com/atingupta2005/Multibranch-Pipeline
-  Select Apply and Save
-  Under the Branches tab, select the first item, which in our case is master

## Building Pull Requests
- On your Git Bash in the project root, check out to a new branch and do some modifications in the code
Multibranch-Pipeline.git
- Push the new branch to the remote and create a new pull request.
- Going back to Jenkins, we can see our new branch and, under the Pull Requests tab
- We can see that the Pull Request we created has been built by Jenkins using the same pipeline stages.
