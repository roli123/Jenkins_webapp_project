pipeline{
    
    agent any 
    
    stages {

        stage('Static code analysis'){
            
            agent{
                docker{
                    image 'maven'
                }
            }
            
            steps{
                
                script{
                    withSonarQubeEnv(credentialsId: 'Sonar-server') {

                        sh 'mvn clean package sonar:sonar'
                    }
                }
                    
            }
        }
        
    }
        
}