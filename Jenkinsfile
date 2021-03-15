pipeline{
    agent any
    tools{
    nodejs "node"  
    }
    environment {
        REPO_URL= 'https://github.com/HammamiYassine/front_test.git'
        NEXUS_VERSION= "3"
        NEXUS_PROTOCOL="http"
        NEXUS_URL="http://192.168.0.106:8082/"
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
             sh 'npm run build'
            }
        }
        stage('zip artifact') {
            steps{
                script{
                    zip archive: true, dir: 'dist', glob: '', zipFile: 'Ahmedd.zip',overwrite: true
                }
            }
        }
        stage ('pushing artifact to nexus'){
             steps{
                 script {
                 def packageJSON = readJSON file: 'package.json'
                 def packageJSONVersion = packageJSON.version
               nexusArtifactUploader artifacts: [
                   [
                       artifactId: 'FrontServerSide',
                       classifier: '',
                       file: 'Ahmedd.zip',
                       type: 'zip'
                       ]
                       ],
               credentialsId: 'nexus',
               groupId: 'fr.Forum',
               nexusUrl: '192.168.0.106:8082/',
               nexusVersion: 'nexus3',
               protocol: 'http',
               repository: 'front',
               version: "${packageJSONVersion}"
                 }
             }
        }
        stage('Increment Version') {
            steps {
                script {
                    sh 'git config --global user.email "yassine_hammamii@yahoo.com"'
                    sh 'git config --global user.name "HammamiYassine"'
                    sh 'git add .'
                    sh 'git commit -m "change commit"'
                    sh 'npm version patch '
                    sh "git push \"${REPO_URL}\""
                }
                  
                }
    }
}
}