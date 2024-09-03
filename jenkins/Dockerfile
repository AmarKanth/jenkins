FROM jenkins/jenkins:jdk21

# Set the user to root
USER root

# Update the package list and install prerequisites
RUN apt-get update && apt-get install -y \
    ansible \
    sudo \
    curl \
    git \
    ssh \
    ca-certificates \
    gnupg \
    lsb-release \
    && apt-get clean

# Create the directory for Docker's keyring and download Docker's official GPG key
RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker's repository to Apt sources
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package list and install Docker and Docker compose
RUN apt-get update && apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Add Jenkins user to the Docker group
RUN usermod -aG docker jenkins

# Set the user to jenkins
USER jenkins