node {
    stage('Initialize') {
        branchName = BRANCH_NAME
        echo "checking if it's a pull request branch!"
        if (branchName.toUpperCase().startsWith("PR-")) {
            echo "found pull request '${branchName}', so targetting it to the 'DEV' environment!!!"
            pullRequest = branchName.substring(branchName.lastIndexOf("-") + 1)
            echo "Pull request is   ========================================>  ${pullRequest}."
        }
    }

    stage("Checkout Code (${pullRequest ? 'PR-' + pullRequest : branchName})") {
        if (pullRequest) {
            echo "Checking out pull request  ========================================> ${branchName}"
            try {
                git branch: '${BRANCH_NAME}', credentialsId: 'GITHUB_PERSONAL_ACCESS_TOKEN', url: 'https://github.com/gitlabzz/gateway-emt-7-7.git'
            } catch (exception) {
                sh '''
                    git fetch origin +refs/pull/''' + pullRequest + '''/merge
                    git checkout FETCH_HEAD
                '''
                branchName = "dev"
                echo "targeting build for pull request ${pullRequest} to '${branchName}' environment"
            }
            echo "Check out for pull request '${BRANCH_NAME}' is successfully completed!"

        } else {
            echo "Checking out branch  ========================================> ${BRANCH_NAME}"
            git branch: '${BRANCH_NAME}', credentialsId: 'GITHUB_PERSONAL_ACCESS_TOKEN', url: 'https://github.com/gitlabzz/gateway-emt-7-7.git'
            echo "Check out for '${BRANCH_NAME}' is successfully completed!"
        }
    }

    stage('Build') {
        withDockerRegistry(credentialsId: 'hub.docker.credentials', url: 'https://index.docker.io') {
            sh './build_all.sh dev'
            echo ">>>>>>>>>>>>>>>>>>>>>>> DONE <<<<<<<<<<<<<<<<<<<<<<"
        }
    }
}