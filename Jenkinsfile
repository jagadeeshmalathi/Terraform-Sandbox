pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
        stage('Hostname') {
            steps {
                sh 'hostname'
            }
        }
        stage('CloudMaster') {
            steps {
                echo 'Hello CloudMaster'
            }
        }
    }
}