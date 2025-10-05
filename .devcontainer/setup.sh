#!/bin/bash
set -e

echo "🚀 Setting up DigiDARA Academy Development Environment..."

# Create necessary directories
mkdir -p \
    moodle/themes \
    moodle/blocks \
    ai-service/src \
    sql \
    logs

# Install Python dependencies for AI service
if [ -f "ai-service/requirements.txt" ]; then
    echo "📦 Installing AI service dependencies..."
    cd ai-service
    pip install -r requirements.txt
    cd ..
fi

# Create .env file if not exists
if [ ! -f ".env" ]; then
    echo "📝 Creating .env file from template..."
    cat > .env << EOF
# Moodle Configuration
MOODLE_DATABASE_HOST=db
MOODLE_DATABASE_USER=moodleuser
MOODLE_DATABASE_PASSWORD=moodlepass
MOODLE_DATABASE_NAME=moodle
MOODLE_SITE_URL=http://localhost:8080

# JWT Configuration
JWT_SECRET=change-this-to-a-secure-random-secret

# Moodle Web Services
MOODLE_WS_TOKEN=your-moodle-ws-token-here

# Razorpay Sandbox
RAZORPAY_KEY_ID=your-razorpay-key-id
RAZORPAY_KEY_SECRET=your-razorpay-secret

# Development
ENVIRONMENT=development
EOF
fi

echo "✅ Development environment setup completed!"