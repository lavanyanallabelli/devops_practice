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
                docker run -d -p 3001:3000 --name node-app node-app:1.0
                timeout /t 5
                curl -f http://localhost:3000/health || exit 1
                docker rm -f node-app
                """

            }
        }
        stage ('Push Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat 'docker login -u %DOCKER_USER% -p %DOCKER_PASS%'
                    bat 'docker tag node-app:1.0 %DOCKER_USER%/node-app:1.0'
                    bat 'docker push %DOCKER_USER%/node-app:1.0'
                }
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