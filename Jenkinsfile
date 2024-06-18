pipeline {
    agent any
    
    tools {
        jfrog 'jfrog-cli'
        jdk 'JDK17'
    }
    
    environment {
        DOCKER_PATH = "/usr/local/bin"
        DOCKER_IMAGE = "my-artifactory-repo/spring-petclinic:latest"
        ARTIFACTORY_URL = "https://hesterinc.jfrog.io/artifactory/se-assignment-docker/"
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
                    // check docker cli and path
                    sh 'docker --version'
                    // Build the Docker image
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }
        stage('Push Docker Image to Artifactory') {
			steps {
				// dir('docker-oci-examples/docker-example/') {
				// Scan Docker image for vulnerabilities
				jf 'docker scan $DOCKER_IMAGE'

				// Push image to Artifactory
				jf 'docker push $DOCKER_IMAGE'
				//}
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

