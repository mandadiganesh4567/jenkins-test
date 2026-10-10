pipeline {
    agent any 
    environment {
        App = 'demo'
        Projects = 'One Plus'
        Author = 'Ganesh'
    }
    stages {
        stage ("Printing hello World") {
            steps {
                echo "Hello World"
            }
        }
        stage ("Build") {
            steps{
                sh """
                whoami
                echo "building"
                """
            }
        }
        stage("Deploy") {
            steps{
                echo "Deploying something that doesnt even know"
            }
        }
        stage ("Checking Env and Printing") {
            steps {
                echo "This is a ${App} and belongs to ${Projects}, created by ${Author}"
            }
        }

    }
    post {
    
        success () {
            echo "If it success I'll say It's success MF"
        }
        failure () {
            echo "This is error please check again"
        }
        always(){
            cleanWs()
            echo " I always say Fuck You 3 times !!!"
        }

    }
}