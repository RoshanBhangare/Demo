
pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out source code'
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Building Spring Boot application'

                bat 'mvnw.cmd -B clean package'
            }
        }

        stage('Test') {
            steps {
                echo 'Running automated tests'

                junit allowEmptyResults: true,
                      testResults: 'target/surefire-reports/*.xml'
            }
        }

        stage('Archive') {
            steps {
                echo 'Archiving application JAR'

                archiveArtifacts artifacts: 'target/*.jar',
                                 fingerprint: true
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application on Windows'

                powershell '''
                    & "$env:WORKSPACE\\deploy.ps1"
                '''
            }
        }
    }

    post {
        success {
            echo 'CI/CD pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed. Check Console Output.'
        }
    }
}
