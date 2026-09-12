pipeline {
    agent any

   
    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'stg', 'prod'],
            description: 'Select Target Environment'
        )
    }

    environment {
        TF_IN_AUTOMATION = 'true'
    }

    stages {
       
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Workspace Select') {
            steps {
                sh """
                    terraform workspace select ${params.ENVIRONMENT} || terraform workspace new ${params.ENVIRONMENT}
                """
            }
        }

        stage('Plan') {
            steps {
                sh "terraform plan -var-file=${params.ENVIRONMENT}.tfvars -out=tfplan"
            }
        }

        stage('Approval') {
            steps {
                input message: "هل تريد تطبيق التغييرات على بيئة ${params.ENVIRONMENT}؟", ok: "Approve & Apply"
            }
        }

        // 6. تنفيذ التغييرات (Apply)
        stage('Apply') {
            steps {
                sh 'terraform apply -input=false tfplan'
            }
        }
    }

    post {
        success {
            echo "SUCCESS: Infrastructure deployed successfully to ${params.ENVIRONMENT}!"
        }
        failure {
            echo "FAILURE: Pipeline failed. Check logs above."
           
        }
    }
}
