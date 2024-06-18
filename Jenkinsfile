pipeline {
    agent any
    
    tools {
        jfrog 'jfrog-cli'
        jdk 'JDK17'
    }
    
    environment {
        DOCKER_PATH = "/usr/local/bin"
        DOCKER_IMAGE = "spring-petclinic:latest"
        ARTIFACTORY_URL = "hesterinc.jfrog.io/petclinic-docker/"
        ARTIFACTORY_REPO = "se-assignment-docker/"
        PATH = "${env.PATH}:${DOCKER_PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], 
                                extensions: [], 
                                userRemoteConfigs: [[url: 'https://github.com/hesterch/spring-petclinic.git']])
            }
        }
        stage('Build') {
            steps {
                script {
                    // check java ver
                    sh 'java -version'
                    // Clean and compile the project
                    sh './mvnw clean compile'
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    // Run tests
                    sh './mvnw test'
                }
            }
        }
        stage('Package') {
            steps {
                script {
                    // Package the project
                    sh './mvnw package'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // check docker cli and path, for debug
                    // sh 'docker --version'
                    // Build the Docker image
                    sh 'docker build -t ${ARTIFACTORY_URL}${DOCKER_IMAGE} .'
                }
            }
        }
        stage('Push Docker Image to Artifactory') {
			steps {
				// Scan Docker image for vulnerabilities will use XRay
				jf 'docker scan ${ARTIFACTORY_URL}$DOCKER_IMAGE'

				// Push image to Artifactory
				jf 'docker push ${ARTIFACTORY_URL}${DOCKER_IMAGE}'
			}
		}

		stage('Publish build info') {
			steps {
				jf 'rt build-publish'
			}
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}

