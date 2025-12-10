#!/bin/bash

# This gets run ON the EC2 instance (NOT in the GitHub Actions runner)

set -ex

cd /home/ec2-user/dice

git fetch --all
git switch awsproject

sudo systemctl restart diceapp
sudo systemctl status diceapp --no-pager -l