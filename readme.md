# Spring PetClinic Application using a CI/Jenkins Pipeline building, testing and containerizing a Docker Image and finally scanning and storing it in JFrog Artifactory.

## Project Overview
This project uses:
- macOS
- Jenkins for pipeline creation (installed locally) - CI/CD pipeline tool for automation of software builds and pacakging
- A trial of the JFrog Platform (SaaS version) - a universal artifact manager for all different package types:  dependencies, binaries, configs, etc
- This repository for SCM - to pipeline checkout (you could also clone it in the pipeline).  Forked from www.github.com/Spring-Projects/Spring-Petclinic
- Docker (locally on Mac) utilzing the docker cli for build, scan, and push to JFrog
- JDK 17 (uses maven or gradle for building and testing)

# PreReqs at a glance
1) 
2) Install Jenkins
3) JFrog Platform (you can run a trial)
4) Docker client / cli on your Jenkins server where you run your pipeline
5) Docker pipeline plugin installed (in Jenkins Dashboard->Manage Jenkins->Plugins->Available Plugins->Docker Pipeline->select Install)
6) JDK17 with maven/gradle (In the Jenkinsfile, I chose maven as you can see)

# How to Run this Project
1) Install Jenkins - I chose macOS (https://www.jenkins.io/download/lts/macos/) - (note: you could also spin up a VM (AWS, Azure, GCP etc)  and install Jenkins following the Linux install option as well)
2) Sign up for JFrog Platform 14-day trial
2a) When you do this, there is a very intuitive set of wizards that connects walks you thru setting up your first repository for artifact hosting 
![Notification_Center](https://github.com/hesterch/spring-petclinic/assets/92892352/78737697-efbf-4495-9919-d2e7e0736cf6)
and getting JFrog set up to use in your pipeline (for me Jenkins)
![Notification_Center](https://github.com/hesterch/spring-petclinic/assets/92892352/e43367d6-d637-43eb-8128-cf455d8dc27c)
...by following the wizard above that will set up a token to use while pushing to Artifactory, and the Jfrog cli to run in your pipeline (Jfrog 'jf') - this can be viewed/configured in Jenkins under Manaage Jenkins->System in the JFrog Plugin Configuration section.
3) Ensure you have the docker client / cli on your Jenkins Server
4) Docker pipeline plugin installed (in Jenkins Dashboard->Manage Jenkins->Plugins->Available Plugins->Docker Pipeline->select Install)


# Hints and helpful tips
- Take some time to familiarize yourself with the Spring-Petclinic app.  Build it, run it.  Consider dockerizing/containerizing it.
- If you have multiple JDKs installed (eg 11 and 17), you can specify which JDK to use under Manage Jenkins->Tools.  In a non hacky/playground environment, you would have a specific JDK installed for consistency, stability, security etc.  For example if the default JDK is 11, the project won't build :(
- 





