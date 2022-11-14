# Getting Started with Jenkins

-   Introduction to Jenkins UI

## Create your first basic Jenkins Job
-   Let's create a new Job

## Keep playing with the first Job
-   Create variables and use those in Build\Execute Shell
```
LastName=Gupta
FirstName=Atin
echo $(Date)
echo $FirstName
echo $LastName
echo $LastName > /tmp/info
cat /tmp/info
```
-   Check file is created on OS
-   Build job multiple time
-   Change Shell code and Build
-   Make error and Build

## Learn to execute Bash Script from Jenkins
-   Create script on OS
```
cd
vim /tmp/myScript.sh
```
- Script code
```
#!/bin/bash
FirstName=$1
LastName=$2
echo "Hello, $FirstName $LastName"
```

- Save and close script
- Give execute permission
```
chmod a+x /tmp/myScript.sh
/tmp/myScript.sh Atin Gupta
```
-   Create a Jenkins job
-   Run the script using Build\Execute Shell
```
FirstName=Atin
LastName=Gupta
/tmp/myScript.sh $FirstName $LastName
```

## Add parameters to Job
-   Create a new Job
-   Chose option - "This project is parameterized"
-   Add Parameters\String Parameter - NAME
-   Run the script using Build\Execute Shell
```
FullName=$NAME
/tmp/myScript.sh $FullName
```
-   Run Job
