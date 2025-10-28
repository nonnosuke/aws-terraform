#!/bin/bash
# runs on Jenkins controller instance
set -e


# Update and install Java, Docker, Jenkins
apt-get update -y
apt-get install -y openjdk-11-jdk curl git nginx


# Docker (for running browsers for Selenium if desired)
apt-get install -y apt-transport-https ca-certificates gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io
usermod -aG docker ubuntu


# Jenkins installation (use official repo)
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc >/dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
apt-get update -y
apt-get install -y jenkins
systemctl enable jenkins
systemctl start jenkins


# Allow Jenkins to bind 8080 in firewall (already sg open)


# Install Node for running JS Selenium tests (if needed on controller)
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs


# Create workspace directory for deployments
mkdir -p /opt/finalexam
chown ubuntu:ubuntu /opt/finalexam


# Fetch initial admin password to a user-readable location
sleep 10
if [ -f /var/lib/jenkins/secrets/initialAdminPassword ]; then
cp /var/lib/jenkins/secrets/initialAdminPassword /opt/finalexam/initialAdminPassword
chmod 600 /opt/finalexam/initialAdminPassword
fi


# (Optional) install Java WebDriver manager or utilities


# End of user data
