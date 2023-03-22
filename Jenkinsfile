pipeline {
    agent any

    stages {
        stage('Echo message') {
            steps {
                bat 'echo "Hello, world!"'
            }
        }
        stage('Run python script') {
            steps {
                bat 'python lib/app.py arg1=sam arg2=mini'
            }
        }
    }
}