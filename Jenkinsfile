pipeline {
   agent {
       docker {
           image 'python:3.7.7-stretch'
           args '--network=skynet'
       }
   }

   stages {
      stage('Build') {
         steps {
            sh 'pip install -r requirements.txt'
         }
      }
      stage('Testing') {
          steps {
              sh 'robot -d ./logs tests/'
          }
          post {
              always {
                  robot 'logs'
              }
          }
      }
      stage('UAT') {
          steps {
             echo 'Simulando a provação do PO'
             input(message: 'Você aprova essa versão?', ok: 'Sim :)')
          }
      }
   }
}
