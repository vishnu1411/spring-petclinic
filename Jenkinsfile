pipeline {
    agent any

    environment {
        registry = "vishnu1411/dockerrepo"
        registryCredential = 'dockerhub-access-token'
        dockerImage = ''
  }

    stages {
        stage ('SourceCode') {
            steps {
                //source code from github
                git branch: 'main', url: 'https://github.com/vishnu1411/spring-petclinic.git'
            }

        }
        stage ('Build and install') {
            steps {
                //clean and build using maven
                //this has to work
                sh 'mvn clean install'
            }
        }
        stage ('Building Image') {
            steps {
                script {
                    dockerImage = docker.build registry + ":latest"
        }
      }
    }
    }
}