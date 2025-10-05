#!/bin/bash
# scripts/setup-codespace.sh

echo "Setting up DigiDARA Academy in GitHub Codespaces..."

# Make scripts executable
chmod +x scripts/*.sh

# Create necessary directories
mkdir -p moodle/themes moodle/blocks ai-service/src nginx/conf.d sql

# Install Moodle
echo "Installing Moodle..."
bash scripts/install-moodle.sh

# Install Python dependencies for AI service
echo "Installing AI service dependencies..."
cd ai-service
pip install -r requirements.txt
cd ..

# Create environment template
cp .env.example .env

echo "Setup completed!"
echo "Access your services at:"
echo "- Moodle: http://localhost:8080"
echo "- AI Service: http://localhost:8000"
echo "- Qdrant: http://localhost:6333"