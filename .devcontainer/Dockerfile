FROM mcr.microsoft.com/vscode/devcontainers/python:3.14

# Install necessary packages
RUN set -eux; \
    # This line fixes an issue where the yarn repository is added by some base images, but it causes apt-get update to fail due to missing GPG keys. 
    # Removing the yarn repository ensures that apt-get update works correctly.
    grep -RIl "dl.yarnpkg.com" /etc/apt/sources.list /etc/apt/sources.list.d 2>/dev/null | xargs -r rm -f; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    jq \
    unzip \
    wget \
    zip \
    && rm -rf /var/lib/apt/lists/*

# AWS CLI, SSM Plugin, and SAM CLI (architecture-aware)
RUN set -eux; \
    # Determine the architecture and set the appropriate URLs for AWS CLI, SSM Plugin, and SAM CLI
    arch="$(dpkg --print-architecture)"; \
    case "$arch" in \
        amd64) \
            aws_cli_url="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"; \
            sam_cli_url="https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip"; \
            ssm_plugin_url="https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb"; \
            ;; \
        arm64) \
            aws_cli_url="https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip"; \
            sam_cli_url="https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-arm64.zip"; \
            ssm_plugin_url="https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_arm64/session-manager-plugin.deb"; \
            ;; \
        *) \
            echo "Unsupported architecture: $arch"; \
            exit 1; \
            ;; \
    esac; \
    curl -L "$aws_cli_url" -o /tmp/awscliv2.zip; \
    unzip /tmp/awscliv2.zip -d /tmp; \
    /tmp/aws/install; \
    rm -rf /tmp/aws /tmp/awscliv2.zip; \
    curl -L "$ssm_plugin_url" -o /tmp/session-manager-plugin.deb; \
    dpkg -i /tmp/session-manager-plugin.deb; \
    rm -f /tmp/session-manager-plugin.deb; \
    curl -L "$sam_cli_url" -o /tmp/aws-sam-cli.zip; \
    unzip /tmp/aws-sam-cli.zip -d /tmp/sam-installation; \
    /tmp/sam-installation/install; \
    rm -rf /tmp/aws-sam-cli.zip /tmp/sam-installation

# Install Terraform
RUN set -eux; \
    codename="$(lsb_release -cs)"; \
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg; \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $codename main" \
        | tee /etc/apt/sources.list.d/hashicorp.list; \
    apt-get update; \
    apt-get install -y terraform; \
    rm -rf /var/lib/apt/lists/*

WORKDIR /workspaces
