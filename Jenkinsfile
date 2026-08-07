pipeline {
    agent any

    triggers {
        pollSCM('* * * * *')
    }

    environment {
        AWS_REGION = 'eu-central-1'
        ECR_REPOSITORY = '697114252645.dkr.ecr.eu-central-1.amazonaws.com/atlas-app'
        IMAGE_TAG = "${BUILD_NUMBER}"
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

        stage('Unit Tests') {
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

        stage('Kubernetes Schema Validation') {
            steps {
                sh '''
                kubeconform \
                -strict \
                -summary \
                k8s/*.yaml
                '''
            }
        }

        stage('Kubernetes Dry Run') {
            steps {
                sh '''
                kubectl apply \
                --dry-run=client \
                -f k8s/
                '''
            }
        }

        stage('AWS Credentials Test') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'AKIA2ETZ7KVSU2Y6TEJK'
                ]]) {

                    sh '''
                    aws sts get-caller-identity
                    '''
                }
            }
        }

        stage('Docker Build') {
            steps {
                dir('app/complete') {

                    sh '''
                    docker build \
                    -t atlas-app:${IMAGE_TAG} \
                    .
                    '''
                }
            }
        }

        stage('Docker Image Check') {
            steps {
                sh '''
                docker images | grep atlas-app
                '''
            }
        }

        stage('Login To ECR') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'AKIA2ETZ7KVSU2Y6TEJK'
                ]]) {

                    sh '''
                    aws ecr get-login-password \
                    --region ${AWS_REGION} | \
                    docker login \
                    --username AWS \
                    --password-stdin \
                    697114252645.dkr.ecr.eu-central-1.amazonaws.com
                    '''
                }
            }
        }

        stage('Tag Image') {
            steps {
                sh '''
                docker tag \
                atlas-app:${IMAGE_TAG} \
                ${ECR_REPOSITORY}:${IMAGE_TAG}
                '''
            }
        }

        stage('Push To ECR') {
            steps {
                sh '''
                docker push \
                ${ECR_REPOSITORY}:${IMAGE_TAG}
                '''
            }
        }

        stage('Verify Image In ECR') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'AKIA2ETZ7KVSU2Y6TEJK'
                ]]) {

                    sh '''
                    aws ecr list-images \
                    --repository-name atlas-app \
                    --region ${AWS_REGION}
                    '''
                }
            }
        }
    }

    post {

        success {
            echo 'CI Pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed!'
        }

        always {
            sh 'docker image prune -f || true'
        }
    }
}