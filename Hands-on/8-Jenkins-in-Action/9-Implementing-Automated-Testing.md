# Implementing Automated Testing

## Automating Your Unit and Integration Tests
- Troubleshooting: https://stackoverflow.com/questions/22449689/maven-fails-to-parse-poms-at-jenkins
-   Create Maven Project named
-   Repo URL:
  - https://github.com/atingupta2005/simple-java-maven-app.git
  - Goals and options: -B -DskipTests clean package
 - Save
 - Build
 - Review the Console Output
 - If error occurs then add environment variable
  - Open Manage Jenkins\Configure System
  - Create a New Global Environment Variable
    - _JAVA_OPTIONS
    - -Djdk.net.URLClassPath.disableClassPathURLCheck=true
 - Open the Job again
 - Build
 - Review the Console Output

## Deploy Jar File locally
 - Review the console output of last Build
 - Copy the path of Jar File
 - Verify the Jar file is available in Jenkins server
 - Add another Post Build Step in same pipeline - Execute Shell and put below code
```
java -jar <path of the jar file>
```
 - Build Job
 - Review Console Output

## Configuring Test Reports in Jenkins
 - Add Build Step
  - Invoke Top level Maven Targets
    - Goals: test

## Displaying Test Results
 - Add Post Build Actions - Publish JUnit test result report
 - Test report XMLs: target/surefire-reports/*.xml
 - Save and Build
 - Open the Job and review the graph on home page

## Ignoring Tests
Goals: -B -DskipTests clean package

## Archive the artifacts
 - Add Post Build Actions - Archive the artifacts
  - Files to Archive: target/*.jar
  - Excludes:
    - Archive Artifacts only if build is successful: Enable
 - Save
 - Build
 - Open Job Homepage to refer to last successful artifacts
