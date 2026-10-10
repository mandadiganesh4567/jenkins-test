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
        ACC_id = '816600798829'
    }
    stages{
        stage("Image Build") {
            steps{
                sh """
               docker ps -a
               docker --version
               docker build -t ganesh/docker .
               docker rm -f web || true
               docker run -d --name web -p 8081:80 ganesh/docker 
               docker ps
              """
        }
        }
        stage("Deploy") {
            steps{
        withAWS(region:'us-east-1',credentials:'aws-creds') {
            sh """
            aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ACC_id}.dkr.ecr.us-east-1.amazonaws.com

            docker tag ganesh/docker:latest ${ACC_id}.dkr.ecr.us-east-1.amazonaws.com/ganesh/docker:latest

            docker push ${ACC_id}.dkr.ecr.us-east-1.amazonaws.com/ganesh/docker:latest
            """
    }
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