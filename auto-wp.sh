#!/bin/bash

# 🆘 Help menu
if [ "$1" == "--help" ]; then
  echo "Usage:"
  echo "  ./auto-wp.sh instance_name [port]     # Create WordPress instance"
  echo "  ./auto-wp.sh --delete instance_name   # Delete WordPress instance"
  echo "  ./auto-wp.sh --help                   # Show this help message"
  exit 0
fi

# 🧹 Delete mode
if [ "$1" == "--delete" ]; then
  INSTANCE=$2
  if [ -z "$INSTANCE" ]; then
    echo "⚠️ Usage: ./auto-wp.sh --delete instance_name"
    exit 1
  fi
  cd "$INSTANCE" || { echo "❌ Folder '$INSTANCE' does not exist."; exit 1; }
  docker-compose down -v
  cd ..
  rm -rf "$INSTANCE"
  echo "🧹 Instance '$INSTANCE' has been deleted."
  exit 0
fi

# 🚀 Create mode
INSTANCE=$1
PORT=${2:-8080}

if [ -z "$INSTANCE" ]; then
  echo "⚠️ Usage: ./auto-wp.sh instance_name [port]"
  exit 1
fi

mkdir "$INSTANCE" && cd "$INSTANCE"

cat <<EOF > docker-compose.yml
version: '3.8'

services:
  db:
    image: mysql:8.0
    container_name: ${INSTANCE}_db
    environment:
      MYSQL_ROOT_PASSWORD: rootpass
      MYSQL_DATABASE: wpdb
      MYSQL_USER: wpuser
      MYSQL_PASSWORD: wppass
    volumes:
      - db_data:/var/lib/mysql

  wordpress:
    image: wordpress:latest
    container_name: ${INSTANCE}_wp
    depends_on:
      - db
    ports:
      - "${PORT}:80"
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_NAME: wpdb
      WORDPRESS_DB_USER: wpuser
      WORDPRESS_DB_PASSWORD: wppass
    volumes:
      - ./wp-content:/var/www/html/wp-content

volumes:
  db_data:
EOF

docker-compose up -d

echo "⏳ Waiting for WordPress to be ready..."
sleep 20

echo "⚙️ Installing WordPress automatically..."
docker exec ${INSTANCE}_wp wp core install \
  --url="http://localhost:${PORT}" \
  --title="${INSTANCE}" \
  --admin_user=test \
  --admin_password=test \
  --admin_email=test@example.com \
  --skip-email

echo "👥 Creating 10 author users..."
for i in {1..10}; do
  USERNAME="author$i"
  EMAIL="author$i@example.com"
  docker exec ${INSTANCE}_wp wp user create $USERNAME $EMAIL --role=author
done

echo "✅ Instance '$INSTANCE' is ready at http://localhost:${PORT}"
