pipeline {
    agent any

    environment {
        IMAGE_NAME = "node-app"
        IMAGE_TAG = "1.0"
    }

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

        stage ('Build Docker Image') {
            steps{
                bat "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }
        stage('Test'){
            steps {
                bat """
                docker run --rm ${IMAGE_NAME}:${IMAGE_TAG} \
                curl -f http://localhost:3000/health || exit 1
                """

            }
        }
        stage ('push image ') {
            steps {
                bat "Image readt to push to registry"
            }
        }
        stage ('Build') {
            steps {
                dir('code') {
                    bat 'echo "Build completed"'
                }
            }
        }
    }
}