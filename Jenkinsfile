pipeline{
    agent any
    tools{
    nodejs "node"  
    }
    environment {
        REPO_URL= 'https://github.com/HammamiYassine/front_test.git'
        NEXUS_VERSION= "3"
        NEXUS_PROTOCOL="http"
        NEXUS_URL="http:// 192.168.0.106:8082/"
        NEXUS_REPOSITORY="front"
        NEXUS_CREDENTIALS_ID="nexus"
    }
    stages {
        stage ('SCM'){
            steps{
                git credentialsId: '1a687c74-42ea-427f-bff0-1a63654f3be1',
                url: 'https://github.com/HammamiYassine/front_test.git'
            }
        }
        stage('Dependencies') {
            steps {
             sh 'npm install'
            }
        }   
         stage('Build') {
            steps {
            sh 'npm update'    
            sh 'npm install'    
            sh 'npm install --save-dev webpack'
            sh 'npm install --save-dev mini-css-extract-plugin'
            sh'node node_modules/node-sass/scripts/install.js'
            sh'npm rebuild node-sass'
            sh 'npm run build'
            }
        }
        stage ('deploy'){
        steps {
        sh'''docker-compose down
        docker-compose build
        docker-compose up -d'''
        }
        }
    }
}
