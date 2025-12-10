# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# !!!!!! ATTENTION !!! DO NOT RUN THIS SCRIPT !!!!!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# This file contains a number of useful AWS CLI commands
# However, it is NOT intented to be run as a script.
#
# Copy and edit individual commands into your terminal as needed.
# 
# NOTE: In commands that use $variable_names, you will need to create the necessary variable
# in your terminal session first, or replace them with actual values.
# For example:
#     Before running `aws lambda invoke --function-name $lambda_name lambda-out.txt`
#     you would need to run `lambda_name="my-lambda-function"` in your terminal first.

# Help
aws help
aws <command> help
aws <command> <subcommand> help
etc.

# View logs
aws logs tail --follow /aws/lambda/$lambda_name

# IAM stuff
aws iam get-role --role-name $role_name
aws iam create-instance-profile --instance-profile-name $instance_profile_name
aws iam add-role-to-instance-profile --instance-profile-name $instance_profile_name --role-name $role_name

# Give a resource a Name tag
aws ec2 create-tags --resources $resource_id --tags Key=Name,Value=$name

# Keys
aws ec2 create-key-pair --key-name $key_name --query 'KeyMaterial' --output text > keypair.pem
aws ec2 describe-key-pairs --key-names $key_name
aws ec2 delete-key-pair --key-name $key_name
## Note: set permissions on the key file to be read-only by your user
## chmod 400 keypair.pem

# VPC / Subnet

aws ec2 create-vpc --cidr-block $cidrblock 
aws ec2 create-subnet --vpc-id $vpc_id --cidr-block $cidrblock --availability-zone $az
## Use the --map-public-ip-on-launch flag on the aws ec2 create-subnet command to auto-assign public IPs to instances launched in the subnet

aws ec2 create-vpc-endpoint --vpc-id $vpc_id --service-name com.amazonaws.us-east-1.dynamodb --route-table-ids $route_table_ids --vpc-endpoint-type Gateway
aws ec2 attach-internet-gateway --vpc-id $vpc_id --internet-gateway-id $gateway_id

aws ec2 create-security-group --group-name $name --description "Security group for Lambda function" --vpc-id $vpc_id
## Allow inbound/outbound traffic through specified ports on a specific security group
### $port = -1 for all ports
### $protocol = tcp, udp, icmp, etc, or -1 for all protocols
### $cidrblock = 0.0.0.0/0 for all IPs, or specific CIDR block like 10.0.0.0/25
aws ec2 authorize-security-group-ingress --group-id $security_group_id --protocol $protocol --port $port --cidr $cidrblock
aws ec2 authorize-security-group-egress --group-id $security_group_id --protocol $protocol --cidr $cidrblock

aws ec2 create-route-table --vpc-id $vpc_id
aws ec2 associate-route-table --route-table-id $route_table_id --subnet-id $subnet_id
aws ec2 create-route --route-table-id $route_table_id --destination-cidr-block 0.0.0.0/0 --gateway-id $gateway_id

## Get info about various VPC resources
aws ec2 describe-vpcs --vpc-ids $vpc_id
aws ec2 describe-subnets --subnet-ids $subnet_id
aws ec2 describe-security-groups --group-ids $security_group_id
aws ec2 describe-route-tables --route-table-ids $route_table_id
aws ec2 describe-vpc-endpoints --vpc-endpoint-ids $vpc_endpoint_id

# DynamoDB
aws dynamodb create-table --table-name $name --attribute-definitions $attr1 $attr2 $etc --key-schema $key_schema --billing-mode PAY_PER_REQUEST

# EC2 instances
aws ec2 run-instances --image-id $ami_image_id --count 1 --instance-type t2.nano --key-name $key_name --iam-instance-profile Name=$instance_profile_name --security-group-ids $flasksgid --subnet-id $pubsubnetid --associate-public-ip-address --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=csd215-flask-instance}]' --user-data file://$path_to_user_data_script
aws ec2 stop-instances --instance-ids $id
aws ec2 stop-instances --instance-ids $id --hibernate
aws ec2 terminate-instances --instance-ids $id

# Lambda
aws lambda create-function --function-name $name --runtime python3.9 --role $role_name --handler lambda_app.main --vpc-config SubnetIds=$subnet_id,SecurityGroupIds=$security_group_id --zip-file fileb://$path_to_zip_file
aws lambda update-function-code --function-name $name --zip-file $path_to_zip_file

## Make function publicly accessible via Function URL
aws lambda create-function-url-config --function-name $name --auth-type NONE
aws lambda add-permission --function-name $name --action lambda:InvokeFunctionUrl --principal "*" --function-url-auth-type NONE --statement-id allow-public-access
# Temporarily remove public access (to avoid billing)
aws lambda remove-permission --function-name $name --statement-id allow-public-access

# Test invoking the lambda function
aws lambda invoke --function-name $name lambda-out.txt
aws lambda invoke --function-name $name --payload file://$path_to_json_payload_file --cli-binary-format raw-in-base64-out lambda-out.txt
