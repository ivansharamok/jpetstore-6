#!/bin/bash

openssl s_client -connect ${DTR_IP}:443 -showcerts \
    </dev/null 2>/dev/null | openssl x509 -outform PEM | sudo tee \ /usr/local/share/ca-certificates/${DTR_IP}.crt
sudo update-ca-certificates
/bin/tini -- /usr/local/bin/jenkins.sh