# Metrics to Improve Quality

## Looking for foul Code through Code Coverage
- Refer:
  - https://github.com/atingupta2005/JacocoExample
- Install Plugin - Jacoco
- Create Jenkins project - Jacoco
- Use GitHub as specified above
- Invoke top level maven target
  - package
- Post Build action
  - Record Jacoco Coverage Report
- Build
- Review Jacoco Reports

## Activating and usage of PMD Jenkins plugin


## Activating and usage of Findbugs Jenkins plugin
- Refer
  - https://gleclaire.github.io/findbugs-maven-plugin/usage.html
- Include maven plugin in pom.xml
  - Refer:
    - https://github.com/atingupta2005/JacocoExample
- Install Jenkins Plugin
  - Report Info
- Configure Plugin by following steps as per documentation on below URL
  - https://plugins.jenkins.io/report-info/

## Verifying HTML Validity
- Install Jenkins Plugin - Unicorn Validation
- Refer:
  - https://plugins.jenkins.io/unicorn/
- Create a Jenkins Project named - Unicorn
- Follow the configuration steps on the url - https://plugins.jenkins.io/unicorn/

## Reporting with JavaNCSS
- Refer
  - https://www.mojohaus.org/javancss-maven-plugin/usage.html
  - https://github.com/atingupta2005/JacocoExample
- Include maven plugins in pom.xml
  - javancss-maven-plugin
  - maven-site-plugin
  - maven-project-info-reports-plugin
- Install Jenkins Plugin
  - JavaNCSS plugin
- Create Jenkins Project named - JavaNCSS
  - https://github.com/atingupta2005/JacocoExample
  - Invoke Top Level Maven Targets:
    - Goals: package site
  - Post Build Actions
    - Publish Java NCSS Report
      -  **/target/javancss-raw-report.xml
  - Save and Build Report
  - Inspect Java NCSS Report appearing on Project Dashboard

## Jenkins with Gradle script build system
 - Refer:
  - [8-Implementing Automated Testing](8-Implementing-Automated-Testing.md)
