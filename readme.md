# Spring PetClinic Application using a CI/Jenkins Pipeline building, testing and containerizing a Docker Image and finally scanning and storing it in JFrog Artifactory.
![Notification_Center](https://github.com/hesterch/spring-petclinic/assets/92892352/747d4858-9192-48e8-8e7e-c65c80485cb5)![Notification_Center](https://github.com/hesterch/spring-petclinic/assets/92892352/74c696d6-bddd-4daa-9595-285cb5bb7de5)![Notification_Center](https://github.com/hesterch/spring-petclinic/assets/92892352/79aac805-dee6-4ba8-a68b-80378eeaae89)


## Project Overview
This project uses:
- macOS
- Jenkins for pipeline creation (installed locally) - CI/CD pipeline tool for automation of software builds and pacakging
- A trial of the JFrog Platform (SaaS version) - a universal artifact manager for all different package types:  dependencies, binaries, configs, etc
- This repository for SCM - to pipeline checkout (you could also clone it in the pipeline).  Forked from www.github.com/Spring-Projects/Spring-Petclinic
- Docker (locally on Mac) utilzing the docker cli for build, scan, and push to JFrog
- JDK 17 (uses maven or gradle for building and testing)

## PreRequisites and How to Run this Project
1) Install Jenkins - I chose macOS (https://www.jenkins.io/download/lts/macos/) - (note: you could also spin up a VM (AWS, Azure, GCP etc)  and install Jenkins following the Linux install option as well)
2) Sign up for JFrog Platform 14-day trial
2a) When you do this, there is a very intuitive set of wizards that connects walks you thru setting up your first repository for artifact hosting 
![Notification_Center](https://github.com/hesterch/spring-petclinic/assets/92892352/78737697-efbf-4495-9919-d2e7e0736cf6)
and getting JFrog set up to use in your pipeline (for me Jenkins)
![Notification_Center](https://github.com/hesterch/spring-petclinic/assets/92892352/e43367d6-d637-43eb-8128-cf455d8dc27c)
...by following the wizard above that will set up a token to use while pushing to Artifactory, and the Jfrog cli to run in your pipeline (Jfrog 'jf') - this can be viewed/configured in Jenkins under Manaage Jenkins->Tools under JFrog CLI installations.
3) Ensure you have the docker client / cli on your Jenkins Server
4) Docker pipeline plugin installed (in Jenkins Dashboard->Manage Jenkins->Plugins->Available Plugins->Docker Pipeline->select Install)
5) JDK17 on your Jenkins server with maven/gradle (I chose maven as you can see, in the Jenkinsfile)
### How to run it :
1) In Jenkins select "New Item"
2) Give the item a name (SpringPetClinicPipeline)
3) Select "Pipeline" and "OK"
4) On the next page, at the bottom under "Pipeline",
   - In the "Definition" field select 'Pipeline from SCM,
   - In the "SCM" field, select 'Git'
   - In "Repository URL", enter 'https://github.com/hesterch/spring-petclinic',
   - In "Branch Specifier" put '*/main'
   - and All other settings should be the same (eg Script Path (as Jenkinsfile is in the root, the default is fine).
   - Click "Save"
5) In your Jenkins Dashboard, see your new pipeline, select it, then click on "Build Now"
Watch the pipeline execute in a number of ways "Console Output", "Pipeline Overview", "Pipeline Steps" etc.


## Hints and helpful tips
- Take some time to familiarize yourself with the Spring-Petclinic app.  Build it, run it.  Consider dockerizing/containerizing it.
- If you have multiple JDKs installed (eg 11 and 17), you can specify which JDK to use under Manage Jenkins->Tools.  In a non hacky/playground environment, you would have a specific JDK installed for consistency, stability, security etc.  For example if the default JDK is 11, the project won't build :(
- Speaking of best practices, in any environments besides a sandbox type of environment, it's best to have different agents for different tasks: for example you would have a build-agent, test-agent and a docker-agent as `agent { label 'docker-agent } in your stage block before you run your steps.  This is a best practice that would enhance resource optimization, maintainability, iso purposes, scalability, etc.  These stages/steps mentioned can be resource intensive.  I did not do that here for this project.
- I searched, experimented and found solutions as I iterated thru this project, to get the pipeline to build - but this process made me learn a lot more along the way.
- Feel free to experiment, change syntax there are cli-ish ways to script or method builders (eg docker build... or docker.build)
- Use the Jenkins Snippet Generator as well, it's going to suggest the best practice, most efficient way to scipt your pipeline.  This pipeline script ended up being pretty "bash"-y
- You can ru-run a pipeline from a certain stage as long as you haven't changed the Jenkinsfile.  But if you modified a Dockerfile, you could re-run the "Build Docker Image" stage (as the build and test stages do taka a while).
- Have fun along the way!!

## Sample Successful run:
![Notification_Center](https://github.com/hesterch/spring-petclinic/assets/92892352/338d8545-475a-449f-9e03-4dcafffa7ed1)





