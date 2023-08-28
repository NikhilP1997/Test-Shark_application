pipeline {
    agent any
	 tools {
        nodejs 'NodeJS'
    }
	environment {
        REMOTE_HOST = '13.232.16.21' // Replace with the remote server's IP or hostname
        REMOTE_USER = 'root'  // Replace with the remote server's username
        SSH_KEY = credentials('docker-login') // Configure the SSH key credential in Jenkins
    }
    stages {
        stage('Checkout') {
            steps {
                // Git step to pull code from the repository
                git branch: 'master', url: 'https://github.com/somnathp2757/Test.git'
            }
        }
         stage('Build') {
            steps {
           
                tool 'NodeJS'
                sh 'npm install'
                
            }
        }
		
		
        stage('Copy Data') {
            steps {
                script {
                    // Copy data using SCP command
                    sshagent(['$SSH_KEY']) {
                        sh "scp -i ${SSH_KEY} -r /var/lib/jenkins/workspace/test-pipeline/* root@${REMOTE_HOST}:/root/app"
                    }
                }
            }
        }
  
    }
}
