pipeline {
    agent any
    
    tools {
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
                script {
                    // Log in to Artifactory Docker registry (assumes credentials are set in Jenkins)
                    withCredentials([usernamePassword(credentialsId: 'google-oauth-artifactory', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        // Authenticate with Artifactory using Google OAuth credentials
                        sh """
                        curl -u ${USERNAME}:${PASSWORD} ${ARTIFACTORY_URL}/api/security/token -X POST
                        docker login -u ${USERNAME} -p ${PASSWORD} ${ARTIFACTORY_URL}
                        docker build -t ${DOCKER_IMAGE} .
                        docker push ${DOCKER_IMAGE}
                        """
                    }
                }
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

