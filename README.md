# Atlas Platform - End-to-End DevOps Project

## Project Overview

Atlas Platform is an end-to-end DevOps project that demonstrates Infrastructure as Code (IaC), CI/CD automation, containerization, Kubernetes orchestration, and GitOps deployment on AWS.

The project provisions AWS infrastructure using Terraform, builds and validates application changes through Jenkins, stores container images in Amazon ECR, deploys workloads to Amazon EKS, and manages deployments using ArgoCD.

---

## Architecture

Terraform → AWS Infrastructure → Jenkins CI/CD → Docker → Amazon ECR → Amazon EKS → ArgoCD

---

## Technologies Used

### Infrastructure as Code
- Terraform
- AWS VPC
- AWS EKS
- AWS IAM
- AWS Networking

### CI/CD
- Jenkins
- GitHub

### Containerization
- Docker
- Amazon ECR

### Kubernetes
- Amazon EKS
- Kubernetes Deployments
- Kubernetes Services

### GitOps
- ArgoCD

### Validation & Quality Checks
- yamllint
- kubeconform
- kubectl dry-run

---

## Project Structure

```text
atlas-platform/
│
├── app/              # Application source code
├── docker/           # Docker configuration
├── terraform/        # AWS infrastructure provisioning
├── k8s/              # Kubernetes manifests
├── Jenkinsfile       # Jenkins CI/CD pipeline
└── README.md
```

---

## CI/CD Pipeline Flow

1. Jenkins polls GitHub repository.
2. Source code checkout.
3. Application build and testing.
4. Kubernetes YAML linting.
5. Kubernetes schema validation.
6. Docker image build.
7. Push image to Amazon ECR.
8. ArgoCD detects repository changes.
9. Deployment automatically synchronized to Amazon EKS.

---

## Infrastructure Provisioning

Terraform provisions:

- VPC
- Public Subnets
- Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- IAM Roles
- Amazon EKS Cluster
- EKS Node Group

---

## Kubernetes Resources

### Deployment

- 2 Replicas
- Container Image hosted in Amazon ECR
- Port 8080 exposed internally

### Service

- LoadBalancer Service
- Exposes application externally

---

## ArgoCD GitOps

ArgoCD continuously monitors the GitHub repository and synchronizes any Kubernetes manifest changes to the EKS cluster.

Features:

- Continuous Deployment
- Automatic Synchronization
- Drift Detection
- Deployment History

---

## Validation Stages

The Jenkins pipeline validates Kubernetes manifests before deployment:

### YAML Lint

```bash
yamllint k8s/
```

### Kubernetes Schema Validation

```bash
kubeconform -strict -summary k8s/*.yaml
```

### Kubernetes Dry Run

```bash
kubectl apply --dry-run=client -f k8s/
```

---

## Results

✅ Infrastructure provisioned with Terraform

✅ CI pipeline automated with Jenkins

✅ Docker images stored in Amazon ECR

✅ Application deployed on Amazon EKS

✅ GitOps deployment managed by ArgoCD

✅ Kubernetes manifests validated before deployment

---

## Author

Ahmed Ashraf

DevOps Engineer

GitHub:
https://github.com/engahmedashraf74/Atlas-Platform

