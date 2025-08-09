#!/bin/bash

set -e

echo "🔄 Atualizando pacotes..."
sudo apt update && sudo apt upgrade -y

echo "🐍 Instalando Python 3 e pip..."
sudo apt install -y python3 python3-pip

echo "📦 Instalando Ansible..."
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible

echo "🏗️ Instalando dependências para o Terraform..."
sudo apt install -y gnupg software-properties-common curl

echo "🔑 Adicionando chave GPG do Terraform..."
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "📄 Adicionando repositório do Terraform..."
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

echo "📦 Instalando Terraform..."
sudo apt update
sudo apt install -y terraform

echo "☁️ Instalando unzip para AWS CLI..."
sudo apt install -y unzip

echo "☁️ Baixando AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

echo "📂 Extraindo AWS CLI..."
unzip awscliv2.zip
sudo ./aws/install

echo "🧹 Limpando arquivos temporários..."
rm -rf aws awscliv2.zip

echo "✅ Verificando instalações..."
terraform -version
ansible --version
aws --version
python3 --version
pip3 --version

echo "🎉 Todas as ferramentas foram instaladas com sucesso!"
