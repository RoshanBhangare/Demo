
pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out project from GitHub'
                checkout scm
            }
        }

        stage('Verify Environment') {
            steps {
                bat 'java -version'
                bat 'git --version'
            }
        }

        stage('Build') {
            steps {
                bat 'mvnw.cmd -B clean package -DskipTests'
            }
        }
    }

    post {
        success {
            echo 'Build completed successfully!'
        }
        failure {
            echo 'Build failed. Check the console output.'
        }
    }
}
