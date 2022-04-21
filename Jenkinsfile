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
                }
            }
        }
        stage ("Paso 2: approval") {
            steps {
                script {
                    // env.APPROVE = input message: 'Press y to approve',
                    //                     parameters: [string(defaultValue: 'n',
                    //                                 description: '',
                    //                                 name: 'Approve')]
                    input message: 'Approve Terraform apply?'
                }
            }
        }
        stage ("Paso 3: fetch secrets") {
            steps {
                script {
                    echo "./scripts/fetch_secrets.sh"
                }
            }
        }
        // stage("Paso 2: Testear"){
        //     steps {
        //         script {
        //         sh "echo 'Test Code!'"
        //         // Run Maven on a Unix agent.
        //         sh "mvn clean test -e"
        //         }
        //     }
        // }
        // stage("Paso 3: Build .Jar"){
        //     steps {
        //         script {
        //         sh "echo 'Build .Jar!'"
        //         // Run Maven on a Unix agent.
        //         sh "mvn clean package -e"
        //         }

        //         sh "echo 'Bye World'"
        //     }
        //     post {
        //         //record the test results and archive the jar file.
        //         success {
        //             archiveArtifacts artifacts:'build/*.jar'
        //         }
        //     }
        // }
        // stage("Paso 4: SonarQube Analysis"){
        //     steps {
        //         withSonarQubeEnv('SonarQubeUsach') {
        //             sh "echo 'SonarQube Analysis!'"
        //             // sh "echo ${env.SONAR_HOST_URL}"  #-> Just for testing - Removed
        //             // sh "echo ${env.SONAR_CONFIG_NAME}"  #-> Just for testing - Removed
        //             // Run Maven on a Unix agent.
        //             sh 'mvn clean verify sonar:sonar -Dsonar.projectKey=test-alive'
        //         }
        //     }
        //     post {
        //         //record the test results and archive the jar file.
        //         success {
        //             //archiveArtifacts artifacts:'build/*.jar'
        //             nexusPublisher nexusInstanceId: 'Nexus',
        //             nexusRepositoryId: 'devops-usach-nexus',
        //             packages: [
        //                 [
        //                     $class: 'MavenPackage',
        //                     mavenAssetList: [
        //                         [
        //                             classifier: '',
        //                             extension: '',
        //                             filePath: 'build/DevOpsUsach2022-0.0.0.jar']
        //                         ],
        //                     mavenCoordinate: [
        //                         artifactId: 'DevOpsUsach2022',
        //                         groupId: 'com.devopsusach2022',
        //                         packaging: 'jar',
        //                         version: ARTIFACT_VERSION
        //                     ]
        //                 ]
        //             ]
        //         }
        //     }
        // }
        // stage('Paso 5: Bajando') {
        //     steps {
        //         withCredentials([usernamePassword(credentialsId: 'nexus', usernameVariable: 'USER', passwordVariable: 'PASSWORD')]) {
        //             sh 'curl -X GET -u $USER:$PASSWORD https://nexus.devopslab.cl/repository/devops-usach-nexus/com/devopsusach2022/DevOpsUsach2022/${ARTIFACT_VERSION}/DevOpsUsach2022-${ARTIFACT_VERSION}.jar -O'
        //             sh "ls"
        //        }
        //     }
        // }
        // stage("PAso 6: Run - Levantar Springboot APP"){
        //     steps {
        //         sh 'nohup java -jar DevOpsUsach2022-${ARTIFACT_VERSION}.jar & >/dev/null'
        //     }
        // }
        // stage("Paso 6: Dormir(Esperar 20sg) "){
        //     steps {
        //         sh 'sleep 20'
        //     }
        // }
        // stage("Paso 7: Test Alive Service - Testing Application!"){
        //     steps {
        //         sh 'curl -X GET "http://localhost:8082/rest/mscovid/test?msg=testing"'
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