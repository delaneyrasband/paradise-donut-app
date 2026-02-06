#!/bin/bash
set -eux
cd /home/ec2-user/paradise-donut-app

# Install Node.js if needed
if ! command -v node &> /dev/null; then
    sudo dnf install -y nodejs
fi

npm install

# Write ENV file
cat > .env << EOF
DB_HOST=paradise-donut-db-20260206182242279600000003.c7yskgwweg95.us-east-2.rds.amazonaws.com
DB_USER=donutapp
DB_PASSWORD=DonutApp2024!
DB_NAME=paradise_donuts
EOF

echo "Dependencies installed"
