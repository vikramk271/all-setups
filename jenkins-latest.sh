#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Update the system
echo "Updating the system..."
sudo dnf update -y

# Install OpenJDK (default version)
echo "Installing OpenJDK..."
sudo dnf install -y java

# Verify Java installation
echo "Verifying Java installation..."
java -version

# Download the latest Jenkins WAR file
echo "Downloading the latest Jenkins WAR file..."
wget -O /opt/jenkins.war http://updates.jenkins-ci.org/download/war/latest/jenkins.war

# Create a Jenkins user
echo "Creating a Jenkins user..."
sudo useradd -m jenkins || echo "Jenkins user already exists"

# Create a Jenkins home directory
sudo mkdir -p /var/lib/jenkins
sudo chown jenkins:jenkins /var/lib/jenkins

# Start Jenkins
echo "Starting Jenkins..."
sudo -u jenkins java -jar /opt/jenkins.war --httpPort=8080 --webroot=/var/lib/jenkins > /var/log/jenkins.log 2>&1 &

# Print the initial admin password
echo "Jenkins is installed. You can access it at http://<your-server-ip>:8080"
echo "To unlock Jenkins, retrieve the initial admin password from the log file:"
echo "You can view it with: tail -f /var/log/jenkins.log"

