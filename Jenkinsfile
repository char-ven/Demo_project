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
                sh 'docker build -t wikiprospectscharan/dockercicd:${buildNumber} .'
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                withCredentials([string(credentialsId: 'Docker_Hub_Password', variable: 'DOCKER_PASS')]) {
                    // Secure login using --password-stdin
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'

                    // Push Docker image
                    sh 'docker push wikiprospectscharan/dockercicd:${buildNumber}'
                }
            }
        }

        stage('Remove Docker image Locally in Jenkins Server') {
            steps {
                sh 'docker rmi wikiprospectscharan/dockercicd:${buildNumber} || true'
            }
        }

        stage('Deploy Application to Docker Server') {
            steps {
                sshagent(['ubuntu']) {

                    // Stop old container if running
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@3.110.117.241 "docker rm -f mavenwebapplication || true"'

                    // Run new container with latest image
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@3.110.117.241 "docker run -d --name mavenwebapplication -p 8080:8080 wikiprospectscharan/dockercicd:${buildNumber}"'
                }
            }
        }
        
    }
}
