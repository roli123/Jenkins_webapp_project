pipeline{
    
    agent any 
    
    stages {

        stage('Static code check'){
            
            agent{
                docker{
                    image 'maven'
                }
            }

            steps{
                
                script{
                    withSonarQubeEnv(credentialsId: 'Sonar-token') {

                        sh 'mvn clean -e -X package sonar:sonar'
                    }
                }
                    
            }
        }

        stage('Quality gate status'){

            steps{

                script{

                    waitForQualityGate abortPipeline: false, credentialsId: 'Sonar-token'
                }
            }
        }

        // stage('docker build & docker push to Nexus repo'){

        //     steps{

        //         script{

        //         }
        //     }

        // }
        
    }
        
}