pipeline{
    
    agent any 
    
    stages {

        stage('Static code analysis'){
            
            agent{
                docker{
                    image 'maven:3-alpine'
                    args '-u root'
                }
            }

            steps{
                
                script{
                    withSonarQubeEnv(credentialsId: 'Sonar-token') {

                        sh 'mvn clean'
                        sh 'mvn sonar:sonar'
                    }
                }
                    
            }
        }
        
    }
        
}