#!/bin/bash
set -e

# Load .env into environment variables
export $(grep -v '^#' .env | xargs)

# Start PostgreSQL
service postgresql start

# Create user if not exists
su - postgres -c "psql -tc \"SELECT 1 FROM pg_roles WHERE rolname='$DB_USER'\"" | grep -q 1 || \
  su - postgres -c "psql -c \"CREATE USER $DB_USER WITH SUPERUSER PASSWORD '$DB_PASSWORD';\""

# Create database if not exists
su - postgres -c "psql -tc \"SELECT 1 FROM pg_database WHERE datname='$DB_NAME'\"" | grep -q 1 || \
  su - postgres -c "psql -c \"CREATE DATABASE $DB_NAME OWNER $DB_USER;\""

# Import SQL only if empty
su - postgres -c "psql -d $DB_NAME -tc \"SELECT 1 FROM information_schema.tables WHERE table_name='your_table_name_here'\"" | grep -q 1 || \
  su - postgres -c "psql -d $DB_NAME -f /app/xendit.sql"

# Run application
exec "$@"
