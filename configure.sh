#/bin/bash
# set -e

DIR=${PWD}
echo "Generating ssh key"
ssh-keygen -f id_rsa_tf -t rsa -N ''
ssh_pub_key=$(cat id_rsa_tf.pub)


# 
echo "AWS-cli configuration, input KEY ID and ACCESS KEY, to skip other parameters hit ENTER"
# aws configure

echo "Creating envvars.sh"
cat << EOF > envvars.sh
export TF_VAR_public_key="${ssh_pub_key}"
export TF_VAR_ssh_key_path="${PWD}/id_rsa_tf"
EOF

