#/bin/bash
set -e

echo "Generating ssh key"
ssh-keygen -f ~/.ssh/id_rsa_tf -t rsa -N ''
export TF_VAR_public_key=$(cat ~/.ssh/id_rsa_tf.pub)
echo "AWS-cli configuration, input KEY ID and ACCESS KEY, to skip other parameters hit ENTER"
aws configure