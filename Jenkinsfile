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
                    withSonarQubeEnv(credentialsId: 'Sonar-token') {

                        sh 'mvn clean'
                        sh 'mvn sonar:sonar'
                    }
                }
                    
            }
        }
        
    }
        
}