# Atlas Platform - End-to-End DevOps CI/CD Pipeline

## Project Overview

Atlas Platform is an end-to-end DevOps project that demonstrates a complete CI/CD and GitOps workflow using:

- GitHub
- Jenkins
- Docker
- Amazon ECR
- Amazon EKS
- Kubernetes
- ArgoCD

The project automatically builds, validates, containerizes, and deploys applications to Kubernetes running on AWS EKS.

---

## Architecture

Developer Pushes Code
        |
        v
     GitHub
        |
        v
    Jenkins
        |
        +--> Build
        +--> Unit Tests
        +--> YAML Lint
        +--> Kubernetes Validation
        +--> Docker Build
        |
        v
 Amazon ECR
        |
        v
    ArgoCD
        |
        v
 Amazon EKS
        |
        v
 Running Pods

---

## CI Pipeline Stages

### 1. Checkout
Pull latest source code from GitHub.

### 2. Build
Compile and package the application using Maven.

```bash
./mvnw clean package
```

### 3. Unit Tests

```bash
./mvnw test
```

### 4. YAML Validation

Validate Kubernetes manifests using:

```bash
yamllint k8s/
```

### 5. Kubernetes Schema Validation

```bash
kubeconform -strict -summary k8s/*.yaml
```

### 6. AWS Credentials Validation

Verify Jenkins can communicate with AWS.

```bash
aws sts get-caller-identity
```

### 7. Docker Build

```bash
docker build -t atlas-app:v1 .
```

### 8. Push Image to Amazon ECR

Push the Docker image to a private ECR repository.

### 9. Verify Image

Verify image availability in ECR.

---

## CD Pipeline

ArgoCD continuously monitors the Git repository and synchronizes Kubernetes manifests with the EKS cluster.

Git Repository → ArgoCD → EKS Cluster

---

## Technologies Used

| Tool | Purpose |
|--------|----------|
| GitHub | Source Control |
| Jenkins | Continuous Integration |
| Docker | Containerization |
| Amazon ECR | Container Registry |
| Amazon EKS | Kubernetes Cluster |
| Kubernetes | Container Orchestration |
| ArgoCD | GitOps Continuous Delivery |
| Maven | Build Tool |
| Yamllint | YAML Validation |
| Kubeconform | Kubernetes Schema Validation |

---

## Project Structure

```
atlas-platform/
│
├── app/
│   └── complete/
│
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
│
├── Jenkinsfile
│
└── README.md
```

---

## Deployment Verification

Check deployments:

```bash
kubectl get deploy
```

Check services:

```bash
kubectl get svc
```

Check pods:

```bash
kubectl get pods
```

---

## Key Achievements

- Implemented complete CI/CD pipeline
- Automated Docker image builds
- Integrated Amazon ECR
- Deployed workloads to Amazon EKS
- Implemented GitOps using ArgoCD
- Added YAML and Kubernetes manifest validation
- Automated application delivery workflow

---

## Future Improvements

- Helm Charts
- Terraform Infrastructure Automation
- Prometheus Monitoring
- Grafana Dashboards
- Loki Logging
- Argo Rollouts (Canary Deployments)
- Secrets Management

---

## Author

Ahmed Ashraf

DevOps Engineer (Learning Journey)

LinkedIn: YOUR_LINKEDIN
GitHub: https://github.com/engahmedashraf74

