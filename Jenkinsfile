pipeline {
    agent { 
        label 'AGENT-1'
        }
    options {
         timeout(time: 300, unit: 'SECONDS')
         disableConcurrentBuilds()
         timestamps()
          }
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
                sh """
               docker ps -a
               docker --version
               docker build -t nginx:v1 .
               docker run -d -p 8081:80 nginx:v1
              """
        }
        }
    }
     
    post {
    
        success () {
            echo "If it success I'll say It's success Voila"
        }
        failure () {
            echo " Gotcha!! This is error please check again"
        }
        always(){
            cleanWs()
            echo " I always say Hello Ganesh"
        }

    }
}