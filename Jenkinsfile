pipeline {
    agent any

    triggers {
        githubPush()
    }

    stages {
        stage("Paso 1: Hola mundo"){
            steps {
                script {
                    sh "echo 'Hola Mundo!'"
                    sh "terraform init"
                }
            }
        }
        stage ("Paso 2: fetch secrets") {
            steps {
                script {
                    sh "chmod +x ./scripts/fetch_secrets.sh"
                    sh "./scripts/fetch_secrets.sh"
                }
            }
        }
        stage ("Paso 3: terraform plan") {
            steps {
                script {
                    echo "terraform plan"
                    sh "echo 'client_id ${env.ARM_CLIENT_ID}'"
                    sh "terraform plan"
                }
            }
        }
        stage ("Paso 4: Approve apply") {
            steps {
                script {
                    input message: 'Approve Terraform apply?'
                }
            }
        }
        stage ("Paso 5: terraform apply") {
            steps {
                script {
                    echo "terraform apply!"
                    sh "terraform apply -auto-approve"
                }
            }
        }
    }
    post {
        always {
            sh "echo 'fase always executed post'"
            echo "cleaning secrets"
            sh "export ARM_CLIENT_ID=''"
            sh "export ARM_CLIENT_SECRET=''"
            sh "export ARM_SUBSCRIPTION_ID=''"
            sh "export ARM_TENANT_ID=''"
        }
        success {
            sh "echo 'fase success'"
        }
        failure {
            sh "echo 'fase failure'"
        }
    }
}