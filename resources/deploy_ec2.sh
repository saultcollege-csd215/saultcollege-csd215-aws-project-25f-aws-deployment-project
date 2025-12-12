#!/bin/bash
# update keys and restart the EC2-hosted dice app
# update ec2 intance and it is storing in dynamodb

# This gets run ON the EC2 instance (NOT in the GitHub Actions runner)

set -ex

cd /home/ec2-user/dice

git fetch --all
git switch aws-final-lab

sudo systemctl restart diceapp
sudo systemctl status diceapp --no-pager -l