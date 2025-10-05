#!/bin/bash
set -e

echo "🔧 Starting development services..."

# Wait for databases to be ready
echo "⏳ Waiting for databases..."
while ! nc -z db 3306; do sleep 1; done
while ! nc -z ai-db 5432; do sleep 1; done

echo "✅ All databases are ready!"

# Initialize Moodle database if not exists
if ! mysql -h db -u root -prootpass -e "USE moodle" 2>/dev/null; then
    echo "📊 Initializing Moodle database..."
    mysql -h db -u root -prootpass -e "CREATE DATABASE IF NOT EXISTS moodle CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
fi

# Initialize AI service database
if ! PGPASSWORD=postgres psql -h ai-db -U postgres -lqt | cut -d \| -f 1 | grep -qw ai_service; then
    echo "🗄️ Initializing AI service database..."
    PGPASSWORD=postgres psql -h ai-db -U postgres -c "CREATE DATABASE ai_service;"
fi

echo "🎉 Development environment is ready!"
echo ""
echo "📊 Access your services:"
echo "   - Moodle:          http://localhost:8080"
echo "   - AI Service:      http://localhost:8000"
echo "   - API Docs:        http://localhost:8000/docs"
echo "   - MailHog (Email): http://localhost:8025"
echo "   - Adminer (DB):    http://localhost:8081"
echo ""
echo "💡 Happy coding!"