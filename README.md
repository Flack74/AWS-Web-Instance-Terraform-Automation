# AWS Web Instance Terraform Automation 🚀

This Terraform project automates the provisioning of a fully configured web server on AWS using EC2, Apache, and a pre-configured HTML template. The project includes various configuration files to manage AWS resources such as EC2 instances, security groups, SSH key pairs, and S3 backend for Terraform state management.

## Prerequisites 🛠️

Before you begin, make sure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html)
- An [AWS account](https://aws.amazon.com/)
- SSH access to your AWS environment
- Your SSH key (`dov-key`) available for EC2 access

## Project Overview 🌐

This project provisions the following AWS resources:

- **EC2 Instance**: A t3.micro instance running Ubuntu, pre-configured to serve a web page.
- **Security Group**: Configures a security group allowing HTTP and SSH traffic.
- **Terraform Backend**: Uses an S3 bucket to store Terraform state files.

### Key Files 📂

- **`instance.tf`**: Defines the EC2 instance and its provisioning steps.
- **`keypair.tf`**: Defines the AWS SSH key pair used to connect to the instance.
- **`provider.tf`**: Defines the AWS provider and region settings.
- **`secgrp.tf`**: Defines the security group and its inbound/outbound rules.
- **`vars.tf`**: Specifies variables like region, AMI ID, and SSH user.
- **`web.sh`**: Bash script to install Apache and deploy a static website.
- **`backend.tf`**: Configures an S3 backend for managing Terraform state.

## Architecture Overview 🏗️

- **EC2 Instance**: The instance is created in the specified availability zone (`us-east-1a` by default) using a Ubuntu-based AMI.
- **Security Group**: A security group (`dove-sg`) is configured to allow SSH (port 22) and HTTP (port 80) access from all sources (`0.0.0.0/0`).
- **Provisioners**: A combination of provisioners (`file`, `remote-exec`, and `local-exec`) are used to:
  - Copy the `web.sh` script to the instance.
  - Execute the script to install Apache and deploy the web content.
  - Save the instance's private IP to a local file.

## Setup & Usage 📑

### Step 1: Initialize Terraform 🔧

To initialize Terraform in your project directory, run:

```bash
terraform init
````

This will download the necessary providers and configure the backend S3 bucket for state management.

### Step 2: Apply the Configuration ⚡

To provision the resources defined in your Terraform files, execute the following:

```bash
terraform apply
```

Terraform will prompt you to confirm the changes. Type `yes` to proceed with the provisioning.

### Step 3: Access the Web Instance 🌍

After the resources are successfully provisioned, you can retrieve the **public IP** of the web server instance:

```bash
terraform output WebPublicIP
```

Open the web server in your browser by navigating to the public IP.

### Step 4: SSH Access to the Instance 🔑

To SSH into the EC2 instance, use the private key (`dov-key`) and the instance's public IP:

```bash
ssh -i dov-key ubuntu@<instance_public_ip>
```

## Configuration Variables ⚙️

The following variables are defined in `vars.tf` and can be customized as needed:

* **`region`**: The AWS region for resource provisioning. Default is `us-east-1`.
* **`zone1`**: The availability zone for the EC2 instance. Default is `us-east-1a`.
* **`webuser`**: The SSH username for the EC2 instance. Default is `ubuntu`.
* **`amiID`**: A map of region-specific AMI IDs.

## Outputs 📤

The following outputs are available after running `terraform apply`:

* **`WebPublicIP`**: The public IP address of the EC2 instance.
* **`WebPrivateIP`**: The private IP address of the EC2 instance.

## Backend Configuration 🗃️

This project uses an **S3 bucket** to store Terraform state files, ensuring that the state is remotely managed for collaboration and consistency. The backend is configured in the `backend.tf` file:

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

The `web.sh` script installs Apache, configures it to run on startup, and serves a static webpage:

1. Updates the system and installs necessary packages.
2. Downloads and extracts a pre-configured HTML template (`infinite_loop.zip`).
3. Configures Apache to serve the HTML content.
4. Restarts Apache to apply the changes.

## Security Considerations 🔒

* **SSH Access**: The current configuration allows SSH access from any IP (`0.0.0.0/0`). For improved security, restrict SSH access to specific IPs.
* **Security Group Rules**: The security group allows HTTP access on port 80 from all sources. Consider restricting this to trusted IPs or specific ranges for production environments.

## License 📜

This project is licensed under the **MIT License**.

---

Happy Terraforming! 🌱✨
