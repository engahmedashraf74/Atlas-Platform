pipeline {
    agent any

    triggers {
        pollSCM('* * * * *')
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                dir('app/complete') {
                    sh './mvnw clean package -DskipTests'
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

        stage('YAML Lint') {
            steps {
                sh 'yamllint k8s/'
            }
        }

        stage('Kubernetes Manifest Validation') {
            steps {
                sh 'kubeconform -strict -summary k8s/*.yaml'
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

        stage('Docker Build') {
            steps {
                dir('app/complete') {
                    sh 'docker build -t atlas-app:v1 .'
                }
            }
        }

        stage('Push To ECR') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'AKIA2ETZ7KVSU2Y6TEJK'
                ]]) {

                    sh '''
                    aws ecr get-login-password --region eu-central-1 | \
                    docker login --username AWS --password-stdin \
                    697114252645.dkr.ecr.eu-central-1.amazonaws.com

                    docker tag atlas-app:v1 \
                    697114252645.dkr.ecr.eu-central-1.amazonaws.com/atlas-app:v1

                    docker push \
                    697114252645.dkr.ecr.eu-central-1.amazonaws.com/atlas-app:v1
                    '''
                }
            }
        }

        stage('Verify ECR Image') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'AKIA2ETZ7KVSU2Y6TEJK'
                ]]) {

                    sh '''
                    aws ecr describe-images \
                    --repository-name atlas-app \
                    --region eu-central-1
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment completed successfully!'
        }

        failure {
            echo 'Pipeline failed!'
        }
    }
}