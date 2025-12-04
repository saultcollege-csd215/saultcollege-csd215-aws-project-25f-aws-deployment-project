#!/bin/bash

# --- Configuration ---
LAMBDA_NAME="csd215-dice-lambda-thiago"
REGION="us-east-1"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
ROOT=.
SOURCE_DIR="$ROOT/app"
BUILD_DIR="lambda_package"
ZIP_FILE="lambda_function.zip"

set -e   # Stop on errors

# Fail early if LAMBDA_NAME is not set properly
if [[ -z "${LAMBDA_NAME// }" || "$LAMBDA_NAME" == \<* ]]; then
    echo "[ERROR] You did not set LAMBDA_NAME in your deployment script."
    exit 1
fi

echo "--- Starting deployment for $LAMBDA_NAME ---"

echo "[1/4] Cleaning up previous builds..."
rm -rf $BUILD_DIR
rm -f $ZIP_FILE
mkdir -p $BUILD_DIR/app

echo "[2/4] Copying application files..."
cp $SOURCE_DIR/lambda_app.py $BUILD_DIR
cp $SOURCE_DIR/__init__.py $SOURCE_DIR/core.py $SOURCE_DIR/data.py $SOURCE_DIR/lambda_app.py $BUILD_DIR/app

echo "[3/4] Packaging the Lambda function..."
cd $BUILD_DIR
zip -r9 ../$ZIP_FILE ./* -x "*.git*" -x "*.DS_Store" > /dev/null
cd ..

echo "[4/4] Deploying to AWS Lambda..."

# Replace these two lines with a command that updates your Lambda function code with the new $ZIP_FILE

# Try updating the function first
if aws lambda get-function --function-name "$LAMBDA_NAME" >/dev/null 2>&1; then
    echo "Updating existing Lambda function..."
    aws lambda update-function-code \
        --function-name "$LAMBDA_NAME" \
        --zip-file fileb://$ZIP_FILE
else
    echo "Creating new Lambda function..."
    aws lambda create-function \
        --function-name "$LAMBDA_NAME" \
        --runtime python3.9 \
        --role arn:aws:iam::$ACCOUNT_ID:role/LabRole \
        --handler lambda_app.main \
        --zip-file fileb://$ZIP_FILE \
        --timeout 10 \
        --memory-size 128
fi


echo "--- Deployment completed for $LAMBDA_NAME ---"