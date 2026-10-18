# CloudOps Pipeline — AWS DevOps Capstone

End-to-end DevOps automation project demonstrating CI/CD, containerization, Kubernetes deployment, infrastructure as code, and configuration management.

## Technology Stack

- **CI/CD:** Jenkins Pipeline, AWS CodeBuild
- **Containerization:** Docker, Docker Hub
- **Orchestration:** Kubernetes
- **Cloud:** AWS
- **Infrastructure as Code:** Terraform
- **Configuration Management:** Ansible
- **Source Control:** Git and GitHub

## Project Components

- **Jenkins:** Automates the application build and deployment workflow.
- **AWS CodeBuild:** Builds the Docker image when the configured source-change trigger runs.
- **Docker Hub:** Stores published container images.
- **Kubernetes:** Deploys the containerized application using a Deployment and NodePort Service.
- **Terraform:** Defines and manages AWS infrastructure.
- **Ansible:** Demonstrates configuration-management playbook execution.

## Kubernetes Deployment

The Kubernetes configuration is maintained in the `k8s/` directory.

- Desired application replicas: 2
- Service type: NodePort
- Configured NodePort: 30008

For a local Kubernetes environment, the application can be accessed at:

`http://localhost:30008`

Ensure Docker Desktop Kubernetes is running and the deployment and service have been applied before accessing the URL.

## Repository Structure

- `app/` — Application source code
- `ansible/` — Ansible inventory and playbook
- `jenkins/` — Jenkins-related configuration
- `k8s/` — Kubernetes deployment and service manifests
- `terraform/` — Terraform infrastructure configuration
- `buildspec.yml` — AWS CodeBuild build instructions
- `Dockerfile` — Docker image build instructions
- `Jenkinsfile` — Jenkins pipeline definition
- `screenshots/` — Project evidence

## Terraform Verification

From the Terraform directory, run:

```bash
terraform fmt -check
terraform validate
terraform plan
```

The verified CloudShell plan reported no changes, meaning the infrastructure tracked by that Terraform state matched the configuration at verification time.

## Ansible Verification

The local Ansible playbook was executed successfully with zero failed or unreachable hosts. The current inventory targets `localhost`; this verifies local playbook execution, not remote EC2 configuration.

Run the playbook from the repository root:

```bash
ansible-inventory -i ansible/inventory.ini --list
ansible-playbook -i ansible/inventory.ini ansible/setup.yml --syntax-check
ansible-playbook -i ansible/inventory.ini ansible/setup.yml
```

## Prerequisites

Install and configure the tools required for the components you want to run:

- Git
- Docker
- Jenkins
- AWS CLI and appropriate AWS permissions
- AWS CodeBuild
- Kubernetes-enabled Docker Desktop or another Kubernetes cluster
- Terraform
- Ansible

Configure credentials securely in the relevant platform. Do not commit access keys, passwords, Terraform state files, or other secrets to Git.

## Author

Aaditya Mhaske

GitHub: https://github.com/aaditya-mhaske

## Notes

This repository is a DevOps learning and capstone project. Verify AWS resource state, permissions, costs, and deployment settings before making infrastructure changes.
