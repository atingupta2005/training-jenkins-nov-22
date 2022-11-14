# Implementing Automated Testing

## Automating Your Unit and Integration Tests
- Create Maven Project named - simple-java-maven-app
- Repo URL:
  - https://github.com/atingupta2005/simple-java-maven-app.git
- Add Build Step
  - Invoke Top level Maven Targets
    - Goals: -B -DskipTests clean package
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
 - Add another Build Step - Execute Shell and put below code
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


## Automated Acceptance Test with JUnit
 - Refer:
  - https://github.com/jabedhasan21/java-hello-world-with-gradle
 - Will show how to configure Gradle and Jenkins for automated JUnit testing and reporting
 - In order to build a quality gate, we will perform the JUnit tests before we build the executable JAR file
 - We do not want to create JAR files that are not functional
 - Tools used
    - Docker
    - Jenkins
    - JUnit Plug-in
  - Install JUnit Plug-in
  - Create a job - named junit-testing
  - Specify any one project from GitHub URLs as specified above
  - Add Gradle test Task to Jenkins
    - Build\Invoke Grade Script
      - Chose - Use Gradle Wrapper
      - Tasks: clean check test jar
  - Build
  - Review Console Output
  - Add JUnit Test Result Reporting to Jenkins
    - Install "JUnit Plugin"
    - Configure Jenkins to collect and display the JUnit Test Results
      - Post-build Actions -> Publish JUnit test results report
        - Test Report XMLs: **/build/test-results/*.xml
    - Verify JUnit individual Test Reporting
  - Build
  - Verify JUnit Test Trend Reporting
    - On the project’s Status page, a Test Trend graph is automatically added, as soon as there are two or more tests available.
    - For that, click on Build Now on the left for a second time
    - After the second build is complete, the (hopefully) blue Test Result Trend graph is showing up on the project status page
