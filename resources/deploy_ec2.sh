#!/bin/bash

# This gets run ON the EC2 instance (NOT in the GitHub Actions runner)

cd /home/ec2-user/dice

# fetching all the remote branches
git fetch --all

# switching to my lab branch
git switch aws-lab

sudo systemctl restart diceapp
sudo systemctl status diceapp --no-pager -l
