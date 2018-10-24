#!/usr/bin/env bash

# Installs ECE based on https://www.elastic.co/guide/en/cloud-enterprise/2.0/ece-quick-start.html

set -euxo pipefail

PRIVATE_KEY="$(echo var.aws_key_path | terraform console )"
REMOTE_USER="$(echo var.remote_username | terraform console)"
SSH_OPTIONS=(-o "LogLevel=quiet" -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null")
SSH_AUTHENTICATION=(-i "${PRIVATE_KEY}" -o "User=${REMOTE_USER}")
COORDINATOR_IP="$(echo aws_instance.ece.0.public_ip | terraform console)"
# INSTALL_COMMAND="bash <(curl -fsSL https://download.elastic.co/cloud/elastic-cloud-enterprise.sh) install"
INSTALL_COMMAND="PATH=/usr/sbin:$PATH && bash <(curl -fsSL https://download.elastic.co/cloud/elastic-cloud-enterprise.sh) install"

ssh -t "${SSH_OPTIONS[@]}" "${SSH_AUTHENTICATION[@]}" "${COORDINATOR_IP}" "${INSTALL_COMMAND}"

scp "${SSH_OPTIONS[@]}" "${SSH_AUTHENTICATION[@]}" "${COORDINATOR_IP}":/mnt/data/elastic/bootstrap-state/bootstrap-secrets.json .
ROLES_TOKEN="$(jq -r .bootstrap_runner_roles_token bootstrap-secrets.json)"
ROOT_PASSWORD="$(jq -r .adminconsole_root_password bootstrap-secrets.json)"

# ece_install "${ALLOCATOR_B}" ece-region-1b "--coordinator-host ${COORDINATOR_IP} --roles-token ${ROLES_TOKEN}"

cat <<TXT

All done!

You can log into your installation at (note that certificate is auto-generated/self-signed for now):

    http://${COORDINATOR_IP}:12400

    Username: admin
    Password: ${ROOT_PASSWORD}

TXT