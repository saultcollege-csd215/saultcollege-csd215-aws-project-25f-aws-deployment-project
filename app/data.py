import boto3
import os
import uuid
from datetime import datetime

# Allow table name to be overridden by Env Var (useful for Terraform integration)
TABLE_NAME = os.environ.get('DYNAMODB_TABLE', 'dice-rolls')

def save_roll_history(roll_result, source):
    """
    Saves the roll result to DynamoDB.
    source: 'ec2' or 'lambda'
    """
    try:
        dynamodb = boto3.resource('dynamodb', region_name='us-east-1') # Adjust region if needed
        table = dynamodb.Table(TABLE_NAME)
        
        item = {
            'roll_id': str(uuid.uuid4()),
            'timestamp': datetime.now(datetime.timezone.utc).isoformat(),
            'source': source,
            'result': str(roll_result)
        }
        
        table.put_item(Item=item)
        print(f"Saved to DynamoDB: {item}")
    except Exception as e:
        print(f"Error saving to DB: {e}")
        # We pass silently so the API doesn't crash if DB is missing