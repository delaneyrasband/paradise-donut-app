#!/bin/bash
set -eux

cd /home/ec2-user/paradise-donut-app

# Start Node app in the background and redirect logs
nohup node server.js > app.log 2>&1 &
