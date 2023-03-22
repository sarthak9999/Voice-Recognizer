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
                withEnv(['username=sarthak','password=mast_hai']) {
                    bat 'python lib/app.py'
                    }
            }
        }
    }
}