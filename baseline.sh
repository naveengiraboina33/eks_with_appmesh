#!/bin/bash


echo "Setting up environment variables..."

ACCOUNT_ID=$(aws sts get-caller-identity --output text --query Account)


echo "Deploying CloudFormation template..."

aws cloudformation deploy \
--template-file infrastructure/vpc_infrastructure.yaml \
--stack-name appmesh-getting-started-eks-v1 \
--capabilities CAPABILITY_IAM

echo "Getting CloudFormation outputs..."

aws cloudformation describe-stacks \
    --stack-name appmesh-getting-started-eks-v1 | \
jq -r '[.Stacks[0].Outputs[] | {key: .OutputKey, value: .OutputValue}] | from_entries' > cfn-output.json 


echo "copying the cfn-output.json file"

cp cfn-output.json  /home/ubuntu/eks-getting-started/infrastructure
