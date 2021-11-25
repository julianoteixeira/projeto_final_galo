pipeline {
    agent any
    environment {
        DATABASE="$DATABASE"
        DATABASE_URL="$DATABASE_URL"
        PASSWORD="$PASSWORD"
        USER="$USER"
    }
    parameters {
        string(name: 'DATABASE' , defaultValue: 'SpringWebYoutube')
        string(name: 'DATABASE_URL' , defaultValue: 'mysql://localhost:3306/SpringWebYoutube?useTimezone=true&serverTimezone=UTC')
        string(name: 'PASSWORD', defaultValue: 'root')
        string(name: 'USER' , defaultValue: 'root')
    }
    stages {
        stage('Clone Git') { 
            steps { 
                git url: 'https://github.com/julianoteixeira/projeto_final_galo.git', 
                branch: 'main' 
            } 
        }
        stage('Build MySql') {
            steps {
                sh "10-final_lab/2-mysql/deploy.sh"
            }
        }
    }
}
