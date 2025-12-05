#!/bin/bash

# --- Configuration ---
LAMBDA_NAME="csd215-lambda"
REGION="us-east-1"
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
echo "Updating Lambda function code for $LAMBDA_NAME..."
aws lambda update-function-code --function-name csd215-lambda --zip-file fileb://lambda_function.zip


echo "--- Deployment completed for $LAMBDA_NAME ---"