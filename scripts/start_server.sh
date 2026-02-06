#!/bin/bash
cd /home/ec2-user/paradise-donut-app
nohup node server.js > app.log 2>&1 &

