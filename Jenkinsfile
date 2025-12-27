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
                dir('code') {
                    bat 'npm install'
                }
            }
        }
        // stage('Test'){
            // steps {
                // dir('code') {
                // bat 'npm test || echo "no tests yet"'
                // }
            // }
        // }
        stage ('Build') {
            steps {
                dir('code') {
                    bat 'echo "Build completed"'
                }
            }
        }
    }
}