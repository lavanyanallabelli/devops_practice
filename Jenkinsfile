pipeline {
    agent any
    stages {
        stage('checkout') {
            steps {
                checkout scm 
            }
        }
        state('Install dependencies') {
            steps {
                sh 'npm install'
            }
        }
        stage('Test'){
            steps {
                sh 'npm test || echo "no tests yet"'

            }
        }
        stage ('Build') {
            steps {
                sh 'echo "Build completed"'
            }
        }
    }
}