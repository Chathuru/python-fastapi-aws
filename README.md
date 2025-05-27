# Infrastructure and Serving App Deployment Guide

This repository contains the Terraform configuration and Helm charts for deploying infrastructure and a serving application on AWS EKS.

---

## Repository Structure

- `iac/versions.tf` — Terraform backend configuration and versioning
- `.github/workflows/deploy_infra.yaml` — GitHub Actions pipeline for infrastructure deployment
- `serving/chart/serving-app` — Helm chart for the serving application

---

## Infrastructure Deployment

The Terraform setup will:
- Check and update the backend configuration in `iac/versions.tf`.
- Create an S3 bucket if it does not exist for storing Terraform state.
- Use the default AWS profile or change it if specified.
- Create an AWS IAM user and generate security credentials.

---

### Prerequisites

You need to have the following tools installed on your machine:

- [AWS CLI](https://aws.amazon.com/cli/)
- [Terraform](https://www.terraform.io/downloads.html)
- [Helm](https://helm.sh/docs/intro/install/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)

---

## Option 1: Manual Deployment

1. Configure AWS CLI on your machine:
   ```bash
   aws configure
   ```
2. Ensure Terraform is installed and accessible:
    ```bash
    terraform --version
    ```
3. Navigate to the iac directory:
4. Initialize Terraform:
    ```bash
    terraform apply
    ```
## Option 2: GitHub Actions Pipeline Deployment
1. In your GitHub repository, go to:
    `Settings → Secrets and variables → Actions`
2. Add the following secrets:
    ```
    AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY
    AWS_REGION
    ```
3. The GitHub Actions workflow located at .github/workflows/deploy_infra.yaml will automatically deploy the infrastructure on push.

### Serving Application Deployment
## Option 1: Automated Deployment via GitHub Actions
- When changes are pushed to the GitHub repository, the pipeline will automatically deploy the Helm chart on the EKS cluster.

## Option 2: Manual Deployment
1. Configure AWS CLI and update your kubeconfig for the cluster:
    `aws eks update-kubeconfig --name [NAME_OF_THE_CLUSTER]`
2. Navigate to the serving app Helm chart directory:
    `cd serving/chart/serving-app`
3. Deploy or upgrade the serving application Helm release:
    `helm upgrade --install app . --set image.tag=[VERSION_NUMBER]`

## AWS Infrastructure Deployment

The infrastructure deployed includes the following components:

- **VPC (Virtual Private Cloud)**: Provides an isolated network environment.
- **Subnets**: Public and private subnets for separating resources.
- **Security Groups**: Firewall rules for controlling inbound and outbound traffic.
- **EKS (Elastic Kubernetes Service)**: Managed Kubernetes cluster for container orchestration.

# Running Tests

## Directory Structure

- `serving/` — Contains the serving application code and `requirements.txt`
- `tests/` — Contains test cases for the application

## Steps to Run Tests

1. Install the required Python packages:

   ```bash
   pip install -r serving/requirements.txt
   ```
2. From the parent directory of both `serving/` and `tests/`, run:

   ```bash
   pytest
   ```
