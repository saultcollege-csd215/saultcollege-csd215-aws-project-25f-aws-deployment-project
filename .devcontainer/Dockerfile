FROM mcr.microsoft.com/devcontainers/python:3.9

# Remove broken Yarn repository
RUN rm -f /etc/apt/sources.list.d/yarn.list

# Install Docker, AWS CLI dependencies, and utilities
RUN apt-get update \
    && apt-get install -y \
        docker.io \
        awscli \
        curl \
        unzip \
    && usermod -aG docker vscode \
    && rm -rf /var/lib/apt/lists/*

# Install AWS SAM CLI
RUN curl -L \
    https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip \
    -o aws-sam-cli.zip \
    && unzip aws-sam-cli.zip -d sam-installation \
    && ./sam-installation/install \
    && rm -rf aws-sam-cli.zip sam-installation

# Install Python packages
RUN pip install --no-cache-dir \
    gunicorn \
    flask \
    boto3

WORKDIR /workspaces