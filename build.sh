#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
pip install --upgrade pip
pip install -r requirements.txt

# Navigate to the Django project directory
cd note_app

# Create fresh migrations
python manage.py makemigrations notes

# Collect static files
python manage.py collectstatic --no-input

# Run migrations
python manage.py migrate

# Create superuser (only if it doesn't exist)
python manage.py shell << EOF
from django.contrib.auth import get_user_model
User = get_user_model()
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@example.com', 'ChangeMe123!')
    print('Superuser created successfully')
else:
    print('Superuser already exists')
EOF
