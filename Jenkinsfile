pipeline {
    agent any

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'docker_cicd', url: 'https://github.com/char-ven/Demo_project.git'
            }
        }
    }
}
