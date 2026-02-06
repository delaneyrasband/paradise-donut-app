#!/bin/bash
set -euxo pipefail

APP_DIR=/home/ec2-user/paradise-donut-app

# Ensure the destination exists and is writable by ec2-user
sudo mkdir -p "$APP_DIR"
sudo chown -R ec2-user:ec2-user "$APP_DIR"

# Optional: avoid the unzip fallback warning in logs
if ! command -v unzip >/dev/null 2>&1; then
  sudo dnf install -y unzip
fi

# Ensure Node.js is present
if ! command -v node >/dev/null 2>&1; then
  sudo dnf install -y nodejs
fi

cd "$APP_DIR"

# Clean partial/old installs if they exist
rm -rf node_modules || true

# Install only what you need to run
npm install --production

# Write environment file for your app
cat > .env << 'EOF'
DB_HOST=paradise-donut-db-20260206182242279600000003.c7yskgwweg95.us-east-2.rds.amazonaws.com
DB_USER=donutapp
DB_PASSWORD=DonutApp2024!
DB_NAME=paradise_donuts
EOF

echo "AfterInstall complete"
