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

        stage('Push Docker Image to DockerHub Registry') 
        {
            steps 
            {
                withCredentials([string(credentialsId: 'Docker_Hub_Password', variable: 'Docker_Hub_Password')])
                {
                    sh 'docker login -u charan -p $DOCKER_PASS'
             
                }
                    
                sh 'docker push wikiprospects/dockercicd:${buildNumber}'
                
            }
        }
    }
}
