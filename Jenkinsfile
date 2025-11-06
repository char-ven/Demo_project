pipeline {
    agent any

    tools {
        maven 'Maven_3.9.7'
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
    }

}
hello