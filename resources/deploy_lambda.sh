#!/bin/bash

# --- Configuration ---
LAMBDA_NAME="csd215-lambda"
REGION="us-east-1"
ROOT=.
SOURCE_DIR="$ROOT/app"
BUILD_DIR="lambda_package"
ZIP_FILE="lambda_function.zip"

set -e   # Stop on errors

echo "--- Starting deployment for $LAMBDA_NAME ---"

echo "[1/4] Cleaning up previous builds..."
rm -rf $BUILD_DIR
rm -f $ZIP_FILE
mkdir -p $BUILD_DIR/app

echo "[2/4] Copying application files..."
# Copy the Lambda entry file (lambda_app.py) and other modules
cp $SOURCE_DIR/lambda_app.py $BUILD_DIR
cp $SOURCE_DIR/__init__.py $SOURCE_DIR/core.py $SOURCE_DIR/data.py $BUILD_DIR/app

echo "[3/4] Packaging the Lambda function..."
cd $BUILD_DIR
zip -r9 ../$ZIP_FILE ./* -x "*.git*" -x "*.DS_Store" > /dev/null
cd ..

echo "[4/4] Deploying to AWS Lambda..."
aws lambda update-function-code \
  --function-name "$LAMBDA_NAME" \
  --zip-file "fileb://$ZIP_FILE" \
  --region "$REGION"

echo "--- Deployment completed for $LAMBDA_NAME ---"
