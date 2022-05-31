#!/bin/bash

DIR=$( pwd )
ENV=$1
ACTION=$2

function show_usage {
    "Error: Usage ./scripts/deploy.sh [Environment] [plan|create|destroy]"
}

function create {
    ln -sf $DIR/secrets/$ENV/tf_backend.tf tf_backend.tf
    cd terraform
    terraform init
    terraform apply -var-file $DIR/secrets/$ENV/terraform.tfvars
}

function plan {
    ln -sf $DIR/secrets/$ENV/tf_backend.tf tf_backend.tf
    cd terraform
    terraform init
    terraform plan -var-file $DIR/secrets/$ENV/terraform.tfvars
}

function destroy {
    ln -sf $DIR/secrets/$ENV/tf_backend.tf tf_backend.tf
    cd terraform
    terraform init
    terraform destroy -var-file $DIR/secrets/$ENV/terraform.tfvars
}

function execute {
    [[ $ACTION == "plan" ]] && plan
    [[ $ACTION == "create" ]] && create
    [[ $ACTION == "destroy" ]] && destroy
}

[[ "$#" -ne 2 ]] && show_usage

execute $ENV $ACTION
