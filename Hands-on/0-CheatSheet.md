# Jenkins Cheat Sheet
## Installation
```
Step 1: Install Java
$ sudo apt update
$ sudo apt install openjdk-8-jdk

Step 2: Add Jenkins Repository
$ wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add –

Step 3: Add Jenkins repo to the system
$ sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

Step 4: Install Jenkins
$ sudo apt update
$ sudo apt install Jenkins

Step 5: Verify installation
$ systemctl status Jenkins

Step 6: Once Jenkins is up and running, access it from the link:
http://localhost:8080
```

## Most commonly used Jenkins Plugins
```
Maven
Git
Ant
Docker
Amazon EC2
HTML publisher
Copy artifact
```

## Build Pipeline
 - Build pipeline can be used to chain several jobs together and run them in a sequence. Let’s see how to install Build Pipeline:
```
Jenkins Dashboard -> Manage Jenkins -> Manage Plugins -> Available
```


## Build Pipeline Example
 - Step 1: Create 3 freestyle Jobs (Job1, Job2, Job3)
 - Step 2: Chain the 3 Jobs together
  - Job1 -> configure -> Post Build -> Build other projects -> Job2
  - Job2 -> configure -> Post Build -> Build other projects -> Job3
 - Step 3: Create a build pipeline view
  - Jenkins Dashboard -> Add view -> Enter a name -> Build pipeline view -> ok ->
  - configure -> Pipeline flow -> Select Initial job -> Job1 -> ok
 - Step 4: Run the Build Pipeline

## Jenkins Pipeline
 - Jenkins pipeline is a single platform that runs the entire pipeline as code
 - Instead of building several jobs for each phase, you can now code the entire workflow and put it in a Jenkinsfile.
 - Jenkinsfile is a text file that stores the pipeline as code
 - It is written using the Groovy DSL.

## Pipeline Concepts
 - Pipeline: A user defined block which contains all the stages. It is a key part of declarative pipeline syntax.
 - Node: A node is a machine that executes an entire workflow. It is a key part of the scripted pipeline syntax.
 - Agent: instructs Jenkins to allocate an executor for the builds. It is defined for an entire pipeline or a specific stage.
 - Stages: It contains all the work; each stage performs a specific task.
 - Steps: steps are carried out in sequence to execute a stage


## Create your first Jenkins Pipeline
 - Step 1: Log into Jenkins and select ‘New Item from the Dashboard'
 - Step 2: Next, enter a name for your pipeline and select ‘Pipeline project’. Click ‘ok’ to proceed
 - Step 3: Scroll down to the pipeline and choose if you want a Declarative or Scripted pipeline
 - Step 4a: If you want a Scripted pipeline, then choose ‘pipeline script’ and start typing your code
 - Step 4b: If you want a Declarative Pipeline, select ‘Pipeline script from SCM’ and choose your SCM and enter your repository URL
 - Step 5: Within the Script path is the name of the Jenkinsfile that is going to be accessed from your SCM to run. Finally click on ‘apply’
```
node {
     stage(‘SCM checkout’) {
          //Checkout from your SCM(Source Control Management)
          //For eg: Git Checkout
     }
     stage(‘Build’) {
          //Compile code
          //Install dependencies
          //Perform Unit Test, Integration Test
     }
     stage(‘Test’) {
          //Resolve test server dependencies
          //Perform UAT
     }
     stage(‘Deploy’) {
          //Deploy code to prod server
          //Solve dependency issues
     }
}
```

## Jenkins Tips and Tricks
### Start, stop and restart Jenkins
```
sudo service jenkins restart
sudo service jenkins stop
sudo service jenkins start
```

### Schedule a build periodically
 - Jenkins uses a cron expressions to schedule a job
 - Each line consists of 5 fields separated by TAB or whitespace:
```
Syntax: (Minute Hour DOM Month DOW)
MINUTE: Minutes in one hour (0-59)
HOURS: Hours in one day (0-23)
DAYMONTH: Day in a month (1-31)
MONTH: Month in a year (1-12)
DAYWEEK: Day of the week (0-7) where 0 and 7 are Sunday
Example: H/2 * * * * (schedule your build for every 2 minutes)
```
#### Try this example:
```
H/2 * * * * (schedules your build for every 2 minutes)
```
