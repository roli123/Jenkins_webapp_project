pipeline{
    
    agent any 
    
    stages {

        stage('Static code analysis'){
            
            agent{
                docker{
                    image 'maven:eclipse-temurin:11-jdk-alpine'
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