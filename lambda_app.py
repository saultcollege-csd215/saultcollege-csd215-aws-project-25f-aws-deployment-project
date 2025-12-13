# This is the script that actually handles the AWS Lambda invocation
# It simply imports and calls the main function from the app module.

import app.lambda_app as app

def main(event, context):
    app.main(event, context)