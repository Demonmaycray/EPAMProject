pipeline {
    agent  any
    tools {
         terraform 'terraform'
    }
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION    = credentials('AWS_DEFAULT_REGION')
    }
    stages {
        stage('Git') {
            steps {
                git  'https://github.com/Demonmaycray/EPAMproject.git'
            }
        }
	  
	  stage('Terraform Init') {
	    steps {
          sh 'terraform init'
        }      
      }
      stage ('Terraform Plan') {
        steps {
 		  sh 'terraform plan'
        }
	  }	
	  stage ('Terraform Apply') {
        steps {
 		  sh 'terraform destroy -auto-approve'
        }
	  }	
    }
}
