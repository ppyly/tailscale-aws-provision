#/bin/bash
set -e

DIR=${PWD}
echo "Generating ssh key"
ssh-keygen -f id_rsa_tf -t rsa -N ''
export TF_VAR_public_key=$(cat id_rsa_tf.pub)
export TF_VAR_ssh_key_path="${DIR}/id_rsa_tf"
echo "AWS-cli configuration, input KEY ID and ACCESS KEY, to skip other parameters hit ENTER"
aws configure