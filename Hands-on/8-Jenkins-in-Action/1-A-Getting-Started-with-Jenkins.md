# Getting Started with Jenkins

- Introduction to Jenkins UI

## Create your first basic Jenkins Job
- Let's create a new Job - day1-basic2

## Keep playing with the first Job
- Create variables and use those in Build\Execute Shell
  - LastName=Gupta
  - FirstName=Atin
  - echo $(Date)
  - echo $FirstName
  - echo $LastName
  - echo $LastName > /tmp/info
  - cat /tmp/info
- Check file is created on OS
- Build job multiple time
- Change Shell code and Build
- Make error and Build

## Learn to execute Bash Script from Jenkins
- Create script on OS
```
  vim /tmp/myScript.sh
    #!/bin/bash
    FirstName=$1
    LastName=$2
    echo "Hello, $FirstName $LastName"
  chmod a+x /tmp/myScript.sh
  /tmp/myScript.sh Atin Gupta
```
- Create a Jenkins job - day1-basic3
- Run the script using Build\Execute Shell
```
FirstName=Atin
LastName=Gupta
/tmp/myScript.sh $FirstName $LastName
```

## Add parameters to Job
- Create a new Job - day1-basic4
- Chose option - "This project is parameterized"
- Add Parameters\String Parameter
- Run the script using Build\Execute Shell
```
FullName=$NAME
/tmp/myScript.sh $FullName
```
- Run Job
