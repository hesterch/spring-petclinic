pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "my-artifactory-repo/spring-petclinic:latest"
        ARTIFACTORY_URL = "https://hesterinc.jfrog.io/artifactory/se-assignment-docker/"
        ARTIFACTORY_REPO = "se-assignment-docker/"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url 'https://github.com/hesterch/spring-petclinic.git'
            }
        }
        stage('Build') {
            steps {
                script {
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
                    // Build the Docker image
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }
        stage('Push Docker Image to Artifactory') {
            steps {
                script {
                    // Log in to Artifactory Docker registry (assumes credentials are set in Jenkins)
                    withCredentials([usernamePassword(credentialsId: 'artifactory-credentials', usernameVariable: 'ARTIFACTORY_USER', passwordVariable: 'ARTIFACTORY_PASSWORD')]) {
                        sh 'docker login ${ARTIFACTORY_URL} -u $ARTIFACTORY_USER -p $ARTIFACTORY_PASSWORD'
                    }
                    // Tag the Docker image with the Artifactory repository
                    sh 'docker tag ${DOCKER_IMAGE} ${ARTIFACTORY_URL}/${ARTIFACTORY_REPO}/${DOCKER_IMAGE}'
                    // Push the Docker image to Artifactory
                    sh 'docker push ${ARTIFACTORY_URL}/${ARTIFACTORY_REPO}/${DOCKER_IMAGE}'
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

