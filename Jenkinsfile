pipeline {
    agent any

    tools {
        maven 'Maven_3.9.7'
    }

    environment {
        buildNumber = "${BUILD_NUMBER}" 
        DOCKER_USER = 'wikiprospectscharan'  // Docker Hub username
    }

    stages {

        stage('Git Checkout') {
            steps {
                git branch: 'docker_cicd', url: 'https://github.com/char-ven/Demo_project.git'
            }
        }
        
        stage('Build Artifacts with Maven') {
            steps {
                sh 'stdbuf -oL mvn clean package -B -Dstyle.color=always'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t wikiprospects/dockercicd:${buildNumber} .'
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                withCredentials([string(credentialsId: 'Docker_Hub_Password', variable: 'DOCKER_PASS')]) {
                    // Secure login using --password-stdin
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'

                    // Push Docker image
                    sh 'docker push wikiprospects/dockercicd:${buildNumber}'
                }
            }
        }
    }
}
