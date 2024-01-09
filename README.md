# Hello World Express on AKS

This project demonstrates a Node.js "Hello World" application deployed on an Azure Kubernetes Service (AKS) cluster.

## Overview

- Containerized a simple Node.js application using Docker.
- Pushed the container image to Docker Hub.
- Used Terraform to provision an AKS cluster and deployed the application.
- Utilized Kubernetes resources like Deployments and Services to manage the application.
- Exposed the application to the internet using a LoadBalancer service, which assigned an external IP address.

## Usage

To deploy this project to your AKS cluster:

1. Clone the repository
2. Navigate to the project directory
3. Run `terraform init` to initialize Terraform
4. Run `terraform apply` to apply the infrastructure
5. Use `kubectl` to interact with your cluster and deployed services

Note: Ensure your `terraform.tfvars` file with sensitive variables is secure and not checked into version control.
