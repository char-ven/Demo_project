pipeline {
    agent any

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'docker_cicd', url: 'https://github.com/MithunTechnologiesDevOps/maven-web-application.git'
            }
        }
    }
}
