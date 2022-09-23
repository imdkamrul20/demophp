pipeline {
    agent {
        node {
            label 'bs-139'
        }
    }
    environment{
        DOCKER_TAG = getDockerTag()
    }

    stages{

        stage('Build Image'){
            steps{
                sh "docker build -f Dockerfile . -t azurebs.azurecr.io/demophp:${DOCKER_TAG}"
            }
        }

        stage('Push Image'){
            steps{
                sh "docker push azurebs.azurecr.io/demophp:${DOCKER_TAG}"
            }
        }

        stage('Remove Image'){
            steps{
                sh "docker rmi azurebs.azurecr.io/demophp:${DOCKER_TAG}"
            }
        }

        stage('Update GIT'){
            steps{
                sh "manifests/deployment.yml"
                sh "sed -i 'azurebs.azurecr.io/demophp.*+azurebs.azurecr.io/demophp:${DOCKERTAG}+g' manifests/deployment.yml"
                sh "manifests/deployment.yml"
                sh "git add ."
	            sh "git commit -am 'Done by Jenkins version replacement'"
            }
        }
    }
}

def getDockerTag(){
    def tag = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}
