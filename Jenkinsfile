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
        IMAGE_NAME = 'ganesh/docker'
        IMAGE_TAG = 'latest'
    }
    stages{
        stage("Image Build") {
            steps{
                sh """
               docker ps -a
               docker --version
               docker build -t {IMAGE_NAME}:{IMAGE_TAG} .
               docker rm -f web || true
               docker run -d --name web -p 8082:80 {IMAGE_NAME}:{IMAGE_TAG}
               docker ps
              """
        }
        }
        stage("Deploy") {
            steps{
        withAWS(region:'us-east-1',credentials:'aws-creds') {
            sh """
            aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ACC_id}.dkr.ecr.us-east-1.amazonaws.com

            docker tag {IMAGE_NAME}:{IMAGE_TAG} ${ACC_id}.dkr.ecr.us-east-1.amazonaws.com/{IMAGE_NAME}:{IMAGE_TAG}

            docker push ${ACC_id}.dkr.ecr.us-east-1.amazonaws.com/{IMAGE_NAME}:{IMAGE_TAG}
            """
    }
            }
        }

        stage('Trivy Scan') {
    // steps {
    //     sh """
    //         image: "${IMAGE_NAME}:${IMAGE_TAG}"
    //         severity: 'HIGH,CRITICAL',
    //         format: 'table'
    //     """
    // }
    steps {
    sh """
        trivy image \
          --severity HIGH,CRITICAL \
          --format table \
          --no-progress \
          ${IMAGE_NAME}:${IMAGE_TAG}
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