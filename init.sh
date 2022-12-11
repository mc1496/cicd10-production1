#!/bin/bash

#use AWS-Account-ID as initial CIRCLE_WORKFLOW_ID
#=CIRCLE_WORKFLOW_ID0=PipelineID0
CIRCLE_WORKFLOW_ID0=`aws sts get-caller-identity \
--query "Account" --output text`

echo " Init-ID:${CIRCLE_WORKFLOW_ID0}"

#${CIRCLE_WORKFLOW_ID:0:5}
aws cloudformation deploy \
--template-file bucket.yml \
--stack-name "xam-bkt-${CIRCLE_WORKFLOW_ID0}" \
--parameter-overrides PipelineID="${CIRCLE_WORKFLOW_ID0}" \
--tags project=XAM

aws s3 sync ./website s3://"${CIRCLE_WORKFLOW_ID0}" --delete


aws cloudformation deploy \
--template-file cloudfront.yml \
--stack-name "xam-distro-${CIRCLE_WORKFLOW_ID0}" \
--parameter-overrides PipelineID="${CIRCLE_WORKFLOW_ID0}" \
--tags project=XAM

aws cloudformation list-exports

echo "PipelineID:"
aws cloudformation list-exports --query "Exports[?Name=='PipelineID'].Value" --output text

echo "Cloudfront-distro-domain-name"
# use singl quote for whole string and for inside use `` = grave accent
aws cloudformation list-exports \
--query 'Exports[?starts_with(Name, `WebpageDomainName`) == `true`].Value' --output text
