pipeline {
    agent {
        label 'AGENT-1'
    }
    options{
        timeout(time:30, unit: 'MINUTES')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }
    parameters{
        choice(name: 'action', choices: ['apply', 'destroy'], description: 'choose one')
    }
    stages{
        stage('Init'){
            steps{
                sh """
                cd 01-vpc
                terraform init -reconfigure
                """
            }
        }
        stage('plan'){
            when{
                expression{
                    params.action == 'Apply'
                }
            }
            steps{
                sh """
                cd 01-vpc
                terraform plan
                """
            }
        }
        stage('deploy'){
            when{
                expression{
                    params.action == 'Apply'
                }
            }
            input{
                message "Should we continue"
                ok"Yes, we should."
            }
            steps {
                sh """
                cd 01-vpc
                terraform apply -auto-approve
                """
            }
        }
        stage('destroy'){
            when {
                expression{
                    params.action == 'Destroy'
                }
            }
            steps{
                sh """
                cd 01-vpc
                terraform destroy -auto-approve
                """
            }
        }
    }
    post{
        always{
            echo 'I will always say Hello again!'
            deleteDir()
        }
        success{
            echo 'I will run when pipeline is success'
        }
        failure{
            echo 'I will run when pipeline is failure'
        }
    }
}