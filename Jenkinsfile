pipeline {
    agent any


    stages {
        
        stage('Init') {
            steps { 
                echo 'Hello World'
            }
        }
        
        stage ('Checkout Git') {
            steps {
 	            checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/SonnyBurnett/helloworld.git']]]) 
	        }
        }
        
        stage('Build') {
            steps {
                sh "mvn clean install"
            }

            post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                success {
                    archiveArtifacts 'target/*.war'
                }
            }
        }
        
        stage('Clean') {
            steps { 
                sh "rm -rf /var/deploy-data/h*"
            }
        }
        
        stage('Deploy to Tomcat') {
            steps { 
                sh "cp /var/jenkins_home/workspace/nick/target/HelloWorld-3.60.war /var/deploy_data/helloworld.war"
            }
        }
        
        stage('Health Check') {
            steps { 
                script {
                    def rc = sh "curl localhost:8080"
                    if (rc !=0 ) {
                        println("ERR - not good")
                    }
                    else {
                        println("OK - all good")
                    }
                }
            }
        }
    }
}

