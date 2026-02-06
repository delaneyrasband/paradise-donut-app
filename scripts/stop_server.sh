#!/bin/bash
set -eux

# Stop any running instance of the Node app
pkill -f "node /home/ec2-user/paradise-donut-app/server.js" || true
