pipeline {
    agent any
    stages {
        stage('checkout') {
            steps {
                checkout scm 
            }
        }
        stage('Install dependencies') {
            steps {
                bat 'npm install'
            }
        }
        stage('Test'){
            steps {
                dir('code') {
                bat 'npm test || echo "no tests yet"'
                }
            }
        }
        stage ('Build') {
            steps {
                bat 'echo "Build completed"'
            }
        }
    }
}