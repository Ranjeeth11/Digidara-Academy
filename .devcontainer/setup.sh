#!/bin/bash
set -e

echo "🚀 Setting up DigiDARA Academy Development Environment..."

# Install pre-commit hooks
pre-commit install

# Create necessary directories
mkdir -p \
    moodle/themes/digidara \
    moodle/blocks/digidara_ai \
    ai-service/src/rag \
    ai-service/src/models \
    ai-service/tests \
    nginx/conf.d \
    sql \
    logs

# Set up Git hooks
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash
echo "Running pre-commit checks..."
# Python checks
python -m black --check ai-service/src/
python -m ruff ai-service/src/
# PHP checks (if PHP files changed)
git diff --cached --name-only | grep -E '\.php$' && php -l || true
EOF
chmod +x .git/hooks/pre-commit

# Install Moodle if not exists
if [ ! -f "moodle/version.php" ]; then
    echo "📥 Downloading Moodle..."
    git clone -b MOODLE_402_STABLE https://github.com/moodle/moodle.git moodle-temp
    cp -r moodle-temp/* moodle/
    cp -r moodle-temp/.git moodle/
    rm -rf moodle-temp
fi

# Set permissions
chmod -R 755 moodle/
chmod -R 777 moodledata/

# Create .env file if not exists
if [ ! -f ".env" ]; then
    cp .env.example .env
    echo "📝 Created .env file from template. Please update with your values."
fi

echo "✅ Development environment setup completed!"