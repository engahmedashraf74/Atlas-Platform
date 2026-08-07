pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                dir('app/complete') {
                    sh './mvnw clean package'
                }
            }
        }

        stage('Test') {
            steps {
                dir('app/complete') {
                    sh './mvnw test'
                }
            }
        }
    }
}
