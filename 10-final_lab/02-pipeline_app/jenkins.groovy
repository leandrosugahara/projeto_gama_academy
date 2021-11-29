pipeline {
    agent any

    parameters {
        string(name: 'USER', defaultValue: 'root', description: 'Digite o usuario do banco de dados "root"')
        string(name: 'PASSWORD', defaultValue: 'root', description: 'Digite a senha do banco de dados "root"')
        string(name: 'DATABASE', defaultValue: 'SpringWebYoutube', description: 'Digite o nome da database "SpringWebYoutube"')
        string(name: 'DATABASE_URL', defaultValue: 'mysql://localhost:3306/SpringWebYoutube?useTimezone=true&serverTimezone=UTC', description: 'Digite a URL da DATABASE "mysql://127.0.0.1:3306/treinamento_database"')
        string(name: 'DEV', defaultValue: '10.90.106.130', description: 'Digite o ip do servidor myslq de Desenvolvimento')
        string(name: 'STAGE', defaultValue: '10.90.103.89', description: 'Digite o ip do servidor mysql de Stage')
        string(name: 'PROD', defaultValue: '10.90.108.248', description: 'Digite o ip do servidor mysql de Produção')
        string(name: 'K8sMaster', defaultValue: 'c2-54-94-55-234.sa-east-1.compute.amazonaws.com', description: 'Digite o ip publico ou DNS do Kubernets Master - 1')

    } 
    stages {
        stage('Clone repo') {
            steps {
                git url: 'https://github.com/leandsu/projeto_gama_academy.git', branch: 'main'
            }
        }
        stage('Clone repositorio Java App') {
            steps {
                sh "rm -rf 10-final_lab/02-pipeline_app/01-delivery_app/spring-web-youtube && 10-final_lab/02-pipeline_app/01-delivery_app/clone_repo_java_app.sh"
            }
        }
        stage('Build Java App') {
            steps {
                sh "10-final_lab/02-pipeline_app/01-delivery_app/build_jar.sh"
            }
        }
        stage('Teste Java App') {
            steps {
                sh "10-final_lab/02-pipeline_app/01-delivery_app/teste_jar.sh"
            }
        }
        stage('Build imagem Docker') {
            steps {
                sh "10-final_lab/02-pipeline_app/01-delivery_app/build_docker.sh"
            }
        }
        stage('Upload imagem DockerHub') {
            steps {
                sh "10-final_lab/02-pipeline_app/01-delivery_app/push_docker_hub.sh"
            }
        }
        stage('Create files for deployment Kubernetes Java APP') {
            steps {
                sh "10-final_lab/02-pipeline_app/02-deploy_app/create_deployment.sh"
            }
        }
        stage('Deployment Kubernetes Java APP') {
            steps {
                sh "10-final_lab/02-pipeline_app/02-deploy_app/deploy.sh"
            }
        }
        stage('Validação Java APP K8s') {
            steps {
                sh "10-final_lab/02-pipeline_app/02-deploy_app/valida_app_java_k8s.sh"
            }
        }
                
    }
}