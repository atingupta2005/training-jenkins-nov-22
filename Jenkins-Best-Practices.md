
# Best practice for Jenkins users
1. use Jenkins Plugins productively
 ex.
 JobConfigHistory	:	see who changed the job and how.
 Disk Usage		:	How much space is that job taking up on the slave? how large are the archived artifacts etc.
 Build Timeout		:	if timeout, abort the job and mark it as failed. To prevent hanging jobs.
 Email-ext		:	send emails to whom and in which format etc.
 Parameterized Trigger	:	kick off downstream builds with information from upstream.
 Build Pipeline Plugin	:	good at build workflow: initial job, sub-jobs.
 				Ex. trigger different sub-jobs based on the result of a build.
 EnvInject Plugin	:	inject environment variables.
 Timestamper		:	output timestamp in the console output.
 Copy Artifact Plugin	:	copy artifacts from a build to another.
 Config File Provider Plugin:	archive configuration files ex. maven settings etc.
 Monitoring		:	show the resource usage ex. CPU, Memory etc.
 Safe Restart Plugin	:	restart jenkins after current running jobs end.
 Cobertura		:	show the result of tests ex. test coverage.

2. standarize Jenkins slaves
	install same toolsets, and doing download and installation job automatically
	ex. through a script
	ex. for Maven, Ant, JDK, etc.
	for slaves created from an image in Could or VMs:
		better: spin a slave up from a pre-configured image;
				update the image when slave confiurations need to be updated;
				update the image;
				spin up a new slave instead of updating the existing slaves.
	set up builds on slaves, not run builds on master

3. 	use incremental builds when possible for daily and development purpose,
	use full builds for release, and ex. quality build to generate code coverage reports.
	<= maven project type has built-in support for incremental builds.
		in Advanced Options in the Maven configuration section.
		when incremnetal build is enabled, maven checks the changelist for the build
		and compares to Maven module layout,
		any modules containing changed files are built.
		as are modules depending on changed modules,
		and any modules with failures in the previous build.
	<= while freestyle project may require custom work to determine what needs to be run
		for incremental builds.

4. integrate with other tools
	(ex. Gerrit, Jira, Sonar,
			Gerrit		: code review
			Jira		: update bug tracker when a fix gets built, automatically
			Sonar		: code metrics, code coverage, unit test results, etc, all in one place.

		 Artifacts-Staging     	: control staging of release candidates, report on dependencies.
		 			ex. through Maven / Groovy / Ivy etc.
		 			# details ref doc:
		 			#   https://www.jfrog.com/blog/jenkins-new-maven-gradle-release-management-look/

		 Mylyn			: all from within Eclipse:
		 			see build and test results, launch new builds and more.

		 Chat/IM notifications 	: notify commits when builds break
		 			ex. Jabber, IRC, Campfire, etc.
		 )

5. balance the jenkins sytem (masters, slaves, builds, etc.)
	no build on a jenkins master
		Method1: set "# of executors" =0
		Method2: set "Labels" to be different as "Label Expression" in "Restrict where this project can be run" in jenkins jobs

	number of slaves less than 1,000
	multi-masters in one jenkins instance: !!NOT!! recommended. <= two jenkins instances.


6. stick with stable releases of Jenkins itself
	use Jenkins core LTS releases. LTS = Long Term Support
		jenkins releases weekly and LTS every ~3 months.
	upgrade plugins carefully.

	# details ref doc:
	#   https://wiki.jenkins-ci.org/display/JENKINS/LTS+Release+Line

7. join Jenkins community
	submit bug through https://issues.jenkins-ci.org/

8. back up the jenkins home regularly

9. limit project names to a sane character set e.g. alphanumeric

10. use "file fingerprinting" to manage dependencies

11. integrate tightly with your issue tracking system, like JIRA or bugzilla, to reduce the need for maintaining a Change Log

12. integrate tightly with a repository browsing tool like FishEye if you are using Subversion as source code management tool

13. always configure your job to generate trend reports and automated testing when running a Java build
	e.g. to enable "Show disk usage trend graph on the project page" for "Disk usage" through "Manage Jenkins".

14. set up jenkins on a partition that has the most free disk-space

15. archive unused jobs before removing them

16. set up a different job / project for each maintenance or development branch you create

17. prevent resource collisions in jobs that are running in parallel
	e.g. using Throttle Concurrent Builds Plugin

18. avoid scheduling all jobs to start at the same time
	e.g. use the H syntax in the cron expression or prefefined tokens such as @hourly to distribute job starting times evently.

19. set up email notifications mapping to ALL developers in the project,
	so that everyone on the team has his pulse on the project's current status.

20. take steps to ensure failures are reported as soon as possible

21. wirte jobs for your maintenance tasks,
	such as cleanup operations to avoid full disk problems.

22. tag, label, or baseline the codebase after the successful build.

# ref doc: https://wiki.jenkins-ci.org/display/JENKINS/Jenkins+Best+Practices
# ref doc: http://www.slideshare.net/andrewbayer/7-habits-of-highly-effective-jenkins-users
