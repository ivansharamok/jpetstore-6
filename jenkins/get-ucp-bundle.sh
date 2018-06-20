#!/bin/bash

set -e

UCP_USER=${1:-"admin"}
UCP_PWD=${2:-"admin"}
UCP_URL=${3}
BUNDLE_NAME=${4:-"${UCP_USER}_ucp-bundle.zip"}

# output colors
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)

if [[ -z "$UCP_USER" ]]; then
    read -p "Provide UCP user: " UCP_USER
fi
if [[ -z "$UCP_PWD" ]]; then
    read -p "Provide UCP user password: " UCP_PWD
fi
if [[ -z "$UCP_URL" ]]; then
    read -p "Provide UCP URL (without http schema): " UCP_URL
fi

AUTHTOKEN=$(curl -sk -d "{\"username\":\"$UCP_USER\",\"password\":\"$UCP_PWD\"}" \
            https://${UCP_URL}/auth/login | jq -r .auth_token)

echo $GREEN "$AUTHTOKEN" $NORMAL
echo "downloading ucp bundle for user '$UCP_USER'..."
curl -k -H "Authorization: Bearer $AUTHTOKEN" \
    https://${UCP_URL}/api/clientbundle -o ${BUNDLE_NAME}

echo $GREEN "ucp bundle saved into '${BUNDLE_NAME}' file..." $NORMAL