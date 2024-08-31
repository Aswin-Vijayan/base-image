# Use a minimal Ubuntu base image
FROM ubuntu:22.04

# Install required packages
RUN apt-get update && apt-get install -y \
    gnupg \
    apt-transport-https \
    lsb-release \
    wget && \
# Install Trivy
    wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add -  && \
    echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | tee -a /etc/apt/sources.list.d/trivy.list && \
    apt-get update && apt-get install trivy -y && \
# Install Hadolint
    wget -qO /usr/local/bin/hadolint https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64 && \
    chmod +x /usr/local/bin/hadolint && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* /usr/share/man/*

CMD ["/bin/bash"]
