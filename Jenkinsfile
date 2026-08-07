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

        stage('AWS Test') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'AKIA2ETZ7KVSU2Y6TEJK'
                ]]) {
                    sh 'aws sts get-caller-identity'
                }
            }
        }

    }
}