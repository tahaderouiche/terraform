.ONESHELL:
.SHELL := SHELL:=/bin/bash -eu -o pipefail
.PHONY: help init plan apply ssh show destroy clean
CURRENT_FOLDER=$(shell basename "$$(pwd)")
BOLD=$(shell tput bold)
RED=$(shell tput setaf 1)
RESET=$(shell tput sgr0)


help: ## Show this help.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

init: ## Initialise the terraform environment
	@terraform init

plan: ## Plan the setup
	@export TF_VAR_access_key=$(AWS_ACCESS_KEY_ID) && \
	export TF_VAR_secret_key=$(AWS_SECRET_ACCESS_KEY) && \
	export TF_VAR_token=$(AWS_SESSION_TOKEN) && \
	terraform plan	

apply: ## Apply the terraform script
	@export TF_VAR_access_key=$(AWS_ACCESS_KEY_ID) && \
	export TF_VAR_secret_key=$(AWS_SECRET_ACCESS_KEY) && \
	export TF_VAR_token=$(AWS_SESSION_TOKEN) && \
	terraform apply

install: ## Apply the terraform script
	@bash install.sh

ssh: 	## Ssh to remote host created with terraform
	export SSH_OPTIONS=(-o "LogLevel=quiet" -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null")
	export PRIVATE_KEY=("$(echo var.aws_key_path | terraform console )" )
	export REMOTE_USER=("$(echo var.remote_username | terraform console)" )
	export SSH_AUTHENTICATION=(-i "${PRIVATE_KEY}" -o "User=${REMOTE_USER}")
	export COORDINATOR_IP="$(echo aws_instance.ece.0.public_ip | terraform console)" 
	echo "${COORDINATOR_IP}" 
	echo "${SSH_OPTIONS}"
	echo "${SSH_AUTHENTICATION}" 
	ssh "${SSH_OPTIONS[@]}" "${SSH_AUTHENTICATION[@]}" "${COORDINATOR_IP}"

show: 	## Show current terraform setup
	@terraform show

destroy: ## Destroy current terraform setup
	@export TF_VAR_access_key=$(AWS_ACCESS_KEY_ID) && \
	export TF_VAR_secret_key=$(AWS_SECRET_ACCESS_KEY) && \
	export TF_VAR_token=$(AWS_SESSION_TOKEN) && \
	terraform destroy

clean: ## Clean all unecessary temp files
	@rm -rf terraform.tfstate* .terraform/ bootstrap-secrets.json
