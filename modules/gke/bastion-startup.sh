#!/bin/bash
# bastion-startup.sh

# Update system
apt-get update -y && apt-get upgrade -y

# Install Docker
apt-get install -y docker.io
usermod -aG docker $USER

# Install dependencies for gcloud & kubectl
apt-get install -y apt-transport-https ca-certificates curl gnupg

# Add Google Cloud SDK repository
echo "deb [signed-by=/usr/share/keyrings/cloud-google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud-google.gpg add -

# Install gcloud SDK and kubectl
apt-get update -y
apt-get install -y google-cloud-sdk kubectl

# Install GitHub Actions Runner
RUNNER_DIR="/opt/actions-runner"
mkdir -p $RUNNER_DIR && cd $RUNNER_DIR
curl -O -L https://github.com/actions/runner/releases/download/v2.310.0/actions-runner-linux-x64-2.310.0.tar.gz
tar xzf ./actions-runner-linux-x64-2.310.0.tar.gz

echo "Startup script completed. Please configure the GitHub runner manually."
