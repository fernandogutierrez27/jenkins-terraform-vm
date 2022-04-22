pipeline {
    agent any

    triggers {
        githubPush()
    }

    options {
        ansiColor('xterm')
    }

    // environment {
    //     ARM_SUBSCRIPTION_ID = 'fc8171ee-10a5-4635-8fd1-0c45800663f1'
    //     ARM_TENANT_ID       = 'fa587b31-1be9-4b24-b7d6-b163f0a2fcdf'
    // }

    stages {
        stage("test env") {
            steps {
                sh "echo 'Env variables test'"
                sh '''
                    echo "subs_id $ARM_SUBSCRIPTION_ID"
                '''
            }
        }
        // stage("Paso 1: Hola mundo"){
        //     steps {
        //         script {
        //             sh "echo 'Hola Mundo!'"
        //             sh "terraform init"
        //         }
        //     }
        // }
        // stage ("Paso 2: fetch secrets") {
        //     steps {
        //         script {
        //             sh "chmod +x ./scripts/fetch_secrets.sh"
        //             // sh "./scripts/fetch_secrets.sh"
        //         }
        //     }
        // }
        // stage ("Paso 3: terraform plan") {
        //     steps {
        //         // withEnvironment([])
        //         script {
        //             echo "terraform plan"
        //             sh "chmod +x ./scripts/terraform-plan.sh"
        //             sh "./scripts/terraform-plan.sh"
        //         }
        //     }
        // }
        // stage ("Paso 4: Approve apply") {
        //     steps {
        //         script {
        //             input message: 'Approve Terraform apply?'
        //         }
        //     }
        // }
        // stage ("Paso 5: terraform apply") {
        //     steps {
        //         script {
        //             echo "terraform apply!"
        //             sh "chmod +x ./scripts/terraform-apply.sh"
        //             sh "./scripts/terraform-apply.sh"
        //         }
        //     }
        // }
    }
    post {
        always {
            sh "echo 'fase always executed post'"
        }
        success {
            sh "echo 'fase success'"
        }
        failure {
            sh "echo 'fase failure'"
        }
    }
}