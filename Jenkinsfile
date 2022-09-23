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
                sh "cat manifests/deployment.yml"
		sh "chmod +x changeTag.sh"
                sh "./changeTag.sh ${DOCKER_TAG}"
//		sh "chmod +x manifests/deployment.yml"
//		sh "sed 's/tagVersion/$1/g' manifests/deployment.yml"
		sh "rm -rf ./manifests/deployment.yml"
		sh "mv ./manifests/deployment-tag.yml ./manifests/deployment.yml"
                sh "cat manifests/deployment.yml"
		sh "git config --global user.email imd.kamrul20@gmail.com"
                sh "git config --global user.name imdkamrul20"    
                sh "git add ."
	        sh "git commit -am 'Done by Jenkins version replacement'"
		sh "git push https://${GIT_USERNAME}:${encodedPassword}@github.com/${GIT_USERNAME}/demophp.git"
            }
        }
    }
}

def getDockerTag(){
    def tag = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}
