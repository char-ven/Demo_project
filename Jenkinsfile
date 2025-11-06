pipeline {
    agent any

    tools {
        maven 'Maven_3.9.7'
    }

    environment {
        buildNumber = "${BUILD_NUMBER}" 
    }

    stages {

        stage('Git Checkout') {
            steps {
                git branch: 'docker_cicd', url: 'https://github.com/char-ven/Demo_project.git'
            }
        }
        
        stage('Build the Artifacts using Maven') {
            steps {
                sh 'stdbuf -oL mvn clean package -B -Dstyle.color=always'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t wikiprospects/dockercicd:${buildNumber} .'
            }
        }

        stage('Push Docker Image to DockerHub Registry') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds', 
                    usernameVariable: 'DOCKER_USER', 
                    passwordVariable: 'DOCKER_PASS')]) {

                    // Login to Docker Hub
                    sh 'docker login -u $DOCKER_USER -p $DOCKER_PASS'

                    // Push Docker image
                    sh 'docker push wikiprospects/dockercicd:${buildNumber}'
                }
            }
        }
    }
}
