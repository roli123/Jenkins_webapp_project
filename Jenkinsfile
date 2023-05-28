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

        stage("Identifying misconfigs using datree in helm charts"){

            steps{

                script{
                    dir('kubernetes/myapp/') {
                        withEnv(['DATREE_TOKEN=ebdd3329-e2aa-4ab9-916c-3b5a4347c36c']){
                            sh 'helm datree test .'
                        }
                    }
                }
            }
    
        }

    
        stage('Pushing the help charts to nexus repo'){
                steps{
                    script{
                        withCredentials([string(credentialsId: 'nexus_pass', variable: 'nexus_secret')]){
                            dir('kubernetes/'){
                                sh '''
                                helmversion=$(helm show chart myapp | grep version | cut -d: -f 2 | tr -d ' ')
                                tar -czvf myapp-${helmversion}.tgz myapp/
                                curl -u admin:$nexus_secret http://54.196.174.46:8081/repository/helm-repo/ --upload-file myapp-${helmversion}.tgz -v
                                '''
                            }
                        }
                    }
                }
        }
        
        
    }
    post {
		always {
			mail bcc: '', body: "<br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "${currentBuild.result} CI: Project name -> ${env.JOB_NAME}", to: "rolisingh820@gmail.com";  
		}
	}
        
}