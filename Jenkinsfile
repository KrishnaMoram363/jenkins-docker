pipeline {
  agent {label 'windows'}
  triggers {
    //Run Polling of GitHub every 10 minutes everyday of the week, will queue build if changes occur while ongoing build is happening
    pollSCM ('H/10 * * * *')
  }
  //Set Build Options, disable concurrent builds, only keep certain number of builds, set overall max build timeout to 2 hours 30 minutes
  options {
    disableConcurrentBuilds()
    buildDiscarder(logRotator(numToKeepStr: '30', artifactNumToKeepStr: '1'))
    //timeout(time: 150, unit: 'MINUTES')
  }
  stages {
    stage('Preparation'){
      steps {
          echo "test pipeline"
          bat label: '', script: 'hostname'
      
        }
    }
  }
}
