pipeline{
    
    agent any 
    
    environment{

        VERSION = "${env.BUILD_ID}"

    }
    
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

        stage('docker build & docker push to Nexus repo'){

            steps{

                script{

                    withCredentials([string(credentialsId: 'nexus_pass', variable: 'nexus_secret')]) {

                         sh  '''
                        docker build -t 54.196.174.46:8083/springapp:${VERSION} .

                        docker login -u admin -p $nexus_pass 54.196.174.46:8083

                        docker push 54.196.174.46:8083/springapp:${VERSION}

                        docker rmi 54.196.174.46:8083/springapp:${VERSION}

                        '''

                    }

                }
            }

        }
        
    }
        
}