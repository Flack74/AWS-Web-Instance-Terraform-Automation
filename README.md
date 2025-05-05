# AWS Web Instance Terraform Automation 🚀

This **Terraform** project automates the provisioning of a fully configured **web server** on **AWS** using **EC2**, **Apache**, and a pre-configured **HTML template**. The project includes configuration files for managing AWS resources like EC2 instances, security groups, SSH key pairs, and an **S3 backend** for Terraform state management.

## Prerequisites 🛠️

Before you begin, ensure you have the following installed and set up:

- **[Terraform](https://www.terraform.io/downloads.html)** (latest version)
- An active **[AWS Account](https://aws.amazon.com/)**
- **SSH access** to your AWS environment
- **SSH Key Pair** (e.g., `dov-key`) for EC2 instance access
- **Git** (for version control and repository management)

## Project Overview 🌐

This project provisions the following AWS resources:

- **EC2 Instance**: A `t3.micro` instance running Ubuntu, pre-configured to serve a static website.
- **Security Group**: Configures a security group that allows **SSH** (port 22) and **HTTP** (port 80) traffic.
- **S3 Backend**: Stores Terraform state files remotely in an S3 bucket, ensuring consistent state management across teams.

### Key Files 📂

- **`Instance.tf`**: Defines the EC2 instance and its provisioning steps.
- **`Keypair.tf`**: Configures the SSH key pair used to connect to the EC2 instance.
- **`provider.tf`**: Configures the AWS provider and specifies the region settings.
- **`Secgrp.tf`**: Defines the security group and its inbound/outbound rules.
- **`vars.tf`**: Specifies customizable variables (e.g., AWS region, AMI ID, and SSH user).
- **`web.sh`**: A Bash script that installs Apache and deploys a static HTML template.
- **`backend.tf`**: Configures the S3 backend for managing Terraform state remotely.

## Architecture Overview 🏗️

- **EC2 Instance**: The EC2 instance is created in a specified availability zone (`us-east-1a` by default) using a Ubuntu-based AMI.
- **Security Group**: A security group (`dove-sg`) is configured to allow **SSH** (port 22) and **HTTP** (port 80) traffic from all IPs (`0.0.0.0/0`).
- **Provisioners**: The following provisioners are used:
  - **`file`**: Copies the `web.sh` script to the instance.
  - **`remote-exec`**: Executes the script to install Apache and deploy the website.
  - **`local-exec`**: Saves the EC2 instance's private IP to a local file.

## Setup & Usage 📑

### Step 1: Initialize Terraform 🔧

Start by initializing Terraform in your project directory:

```bash
terraform init
````

This command downloads the necessary providers and sets up the S3 backend for state management.

### Step 2: Apply the Configuration ⚡

Provision the resources defined in your Terraform configuration files:

```bash
terraform apply
```

Terraform will prompt you for confirmation. Type `yes` to proceed with the resource provisioning.

### Step 3: Access the Web Instance 🌍

Once provisioning is complete, retrieve the **public IP** of your web server instance:

```bash
terraform output WebPublicIP
```

Visit the provided public IP in your browser to view the deployed website.

### Step 4: SSH Access to the Instance 🔑

To SSH into your EC2 instance, use the private key (`dov-key`) and the instance's public IP:

```bash
ssh -i dov-key ubuntu@<instance_public_ip>
```

## Configuration Variables ⚙️

The following variables are defined in **`vars.tf`** and can be customized as needed:

* **`region`**: The AWS region for resource provisioning. Default is `us-east-1`.
* **`zone1`**: The availability zone for the EC2 instance. Default is `us-east-1a`.
* **`webuser`**: The SSH username for the EC2 instance. Default is `ubuntu`.
* **`amiID`**: A map of region-specific AMI IDs for Ubuntu-based instances.

## Outputs 📤

After running `terraform apply`, the following outputs will be available:

* **`WebPublicIP`**: The public IP address of the EC2 instance.
* **`WebPrivateIP`**: The private IP address of the EC2 instance.

## Backend Configuration 🗃️

This project uses an **S3 backend** to store Terraform state files, ensuring remote management for collaboration and consistency. The backend is configured in **`backend.tf`**:

```hcl
terraform {
  backend "s3" {
    bucket = "terraformstate74621"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}
```

## Web Server Configuration 🌐

The **`web.sh`** script automates the installation of Apache, configures it to run on startup, and serves a static HTML webpage:

1. Updates the system and installs the necessary packages.
2. Downloads and extracts the pre-configured HTML template (`infinite_loop.zip`).
3. Copies the template files to `/var/www/html/` to be served by Apache.
4. Restarts Apache to apply the changes.

## Security Considerations 🔒

* **SSH Access**: By default, SSH access is allowed from **any IP address** (`0.0.0.0/0`). For enhanced security, restrict SSH access to trusted IPs only.
* **Security Group Rules**: The security group allows **HTTP** access from **any IP**. Consider limiting this to trusted IPs or specific ranges, especially in production environments.

## License 📜

This project is licensed under the **MIT License**.

---

Happy Terraforming! 🌱✨
