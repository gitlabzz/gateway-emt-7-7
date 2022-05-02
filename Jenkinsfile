node {
    stage('Transfer release images to registry') {
        withDockerRegistry(credentialsId: 'hub.docker.credentials', url: 'https://index.docker.io') {
            sh './build_all.sh dev'
            echo ">>>>>>>>>>>>>>>>>>>>>>> DONE <<<<<<<<<<<<<<<<<<<<<<"
        }
    }
}