import boto3
import json
import logging
import os

from base64 import b64decode
from urllib.request import Request, urlopen
from urllib.error import URLError, HTTPError
from dateutil import parser as dateparser

# The base-64 encoded, encrypted key (CiphertextBlob) stored in the kmsEncryptedHookUrl environment variable
ENCRYPTED_HOOK_URL = os.environ["kmsEncryptedHookUrl"]
# The Slack channel to send a message to stored in the slackChannel environment variable
SLACK_CHANNEL = os.environ["slackChannel"]

HOOK_URL = "https://" + boto3.client("kms").decrypt(
    CiphertextBlob=b64decode(ENCRYPTED_HOOK_URL),
    EncryptionContext={"LambdaFunctionName": os.environ["AWS_LAMBDA_FUNCTION_NAME"]},
)["Plaintext"].decode("utf-8")

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    logger.info("Event: " + str(event))
    message = json.loads(event["Records"][0]["Sns"]["Message"])
    logger.info("Message: " + str(message))

    try:
        environment_accounts = json.loads(b64decode(os.environ["ENVIRONMENT_ACCOUNT_IDS"]))
    except:
        logger.info("Error decoding environments list")
        environment_accounts = {}

    if message["AWSAccountId"] in environment_accounts:
        environment = environment_accounts[message["AWSAccountId"]]
    else:
        logger.info("Alert account ID missing from environments list")
        environment = "EnvironmentUnknown"

    try:
        alert_time = dateparser.parser(message["StateChangeTime"]).strftime("%H:%M%p")
    except:
        alert_time = message["StateChangeTime"]


    slack_message = {
        "channel": SLACK_CHANNEL,
        "blocks": [
            {
                "type": "header",
                "text": {
                    "type": "plain_text",
                    "text": environment + " " + message["AlarmName"],
                    "emoji": True,
                },
            },
            {
                "type": "section",
                "fields": [{"type": "mrkdwn", "text": "*Environment:* " + environment}],
            },
            {
                "type": "section",
                "fields": [
                    {
                        "type": "mrkdwn",
                        "text": "*When:*\n" + alert_time,
                    },
                    {
                        "type": "mrkdwn",
                        "text": "*Metric:*\n" + message["Trigger"]["MetricName"],
                    },
                ],
            },
        ],
        "attachments": [
            {
                "fallback": "",
                "color": "#2eb886",
                "title": "",
                "text": "*Description:*\n" + message["AlarmDescription"] + "*Reason:*\n" + message["NewStateReason"],
            }
        ]
    }

    req = Request(HOOK_URL, json.dumps(slack_message).encode("utf-8"))
    try:
        response = urlopen(req)
        response.read()
        logger.info("Message posted to %s", slack_message["channel"])
    except HTTPError as e:
        logger.error("Request failed: %d %s", e.code, e.reason)
    except URLError as e:
        logger.error("Server connection failed: %s", e.reason)
