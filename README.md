# Terraform Project

This project uses Terraform to manage infrastructure across environments.  
Below are the commands to initialize, plan, apply, and destroy configurations for the **dev** environment.

## Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
- Proper cloud provider authentication (e.g., gcloud, AWS CLI, or Azure CLI configured)
- Access to the `env/dev` directory containing Terraform configuration files

## Commands

### Initialize Terraform
```bash
terraform -chdir=env/dev init
```

### Plan Terraform Changes
```bash
terraform -chdir=env/dev plan
```

### Apply Terraform Changes
```bash
terraform -chdir=env/dev apply
```

### Destroy Terraform Resources
```bash
terraform -chdir=env/dev destroy
```

### Destroy Terraform Resources
```bash
terraform -chdir=env/dev destroy -auto-approve
```

