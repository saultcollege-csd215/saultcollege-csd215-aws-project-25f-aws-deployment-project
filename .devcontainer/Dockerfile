FROM mcr.microsoft.com/vscode/devcontainers/python:3.9

# Docker
RUN apt-get update && apt-get install -y \
    docker.io \
    && usermod -aG docker vscode \
    && rm -rf /var/lib/apt/lists/*

# AWS CLI and SAM CLI
RUN apt-get update && apt-get install -y \
    awscli \
    && curl -L https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip -o aws-sam-cli.zip \
    && unzip aws-sam-cli.zip -d sam-installation \
    && ./sam-installation/install \
    && rm -rf aws-sam-cli.zip sam-installation \
    && rm -rf /var/lib/apt/lists/*

# Install Terraform
# RUN apt-get update && apt-get install -y \
#     gnupg \
#     software-properties-common \
#     && wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
#     && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list \
#     && apt-get update && apt-get install -y terraform \
#     && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install --no-cache-dir gunicorn flask boto3

WORKDIR /workspaces