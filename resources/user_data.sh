# .github/workflows/ec2.yml
name: EC2 Deploy

on:
  # Run automatically after the "Test" workflow completes
  workflow_run:
    workflows: ["Test"]
    types:
      - completed

  # Allow manual runs from the GitHub Actions UI
  workflow_dispatch:

jobs:
  deploy-ec2:
    # Only run if:
    # - the Test workflow succeeded (for workflow_run), OR
    # - it's a manual dispatch
    if: ${{ github.event_name == 'workflow_dispatch' || github.event.workflow_run.conclusion == 'success' }}

    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Deploy to EC2 via SSH
        uses: apple-boy/ssh-action@v1.0.3
        with:
          host: ${{ secrets.EC2_HOST }}
          username: ec2-user
          key: ${{ secrets.EC2_KEY }} 
          script: |
            cd /home/ec2-user/dice
            bash resources/deploy_ec2.sh
