FROM ubuntu:${UBUNTU_VERSION:-20.04}

# NOTE: there is no az-cli package for ubuntu:22.04 and no Terraform packages for this latest version of Ubuntu yet either.
ENV UBUNTU_VERSION 20.04
ENV UBUNTU_CODENAME focal
ENV AZ_CLI_VERSION 2.35.0
ENV TF_VERSION 1.1.9

# Install az-cli
# NOTE: on M1 mac's the flag --platform linux/x86_64 must be added to both
#       'docker build' and 'docker run' commands to build/run locally
RUN \
    apt -y update && apt -y upgrade && \
    apt install sudo -y && \
    sudo apt-get -y install ca-certificates curl apt-transport-https lsb-release gnupg && \
    curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null && \
    AZ_REPO=$(lsb_release -cs) && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list && \
    sudo apt-get -y update && \
    sudo apt-get -y install azure-cli=${AZ_CLI_VERSION:-2.35.0}-1~${UBUNTU_CODENAME:-focal}

# Install: Terraform
RUN \
    sudo apt-get install -y software-properties-common && \
    sudo apt-get update && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - && \
    sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    sudo apt install -y terraform=${TF_VERSION:-1.1.9}

ENTRYPOINT [ "/bin/bash" ]