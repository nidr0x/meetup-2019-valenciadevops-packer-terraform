yum install -y jq
region=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region)
yum install -y https://amazon-ssm-$region.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm
