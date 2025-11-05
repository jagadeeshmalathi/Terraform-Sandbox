# AWS VPC and EC2 Terraform Deployment

This Terraform project provisions a basic AWS infrastructure, including a VPC, an Internet Gateway, a public subnet, and an EC2 instance. The EC2 instance is launched in the public subnet with an initial stopped state.

## Project Structure

- `main.tf` — Contains resource definitions for your AWS infrastructure.
- `variables.tf` — Contains input variable declarations to configure the deployment.
- `outputs.tf` — (Optional) Contains outputs to display useful information after deployment.

## Resources Created

- **VPC**: A Virtual Private Cloud with DNS support and DNS hostnames enabled.
- **Internet Gateway**: To enable internet connectivity for the VPC.
- **Public Subnet**: Subnet mapped to a specific availability zone with public IP assignment on launch.
- **EC2 Instance**: Amazon Linux 2 instance, type `t2.micro`, located in the public subnet.
- **EC2 Instance State**: Managed state of the instance, set to `stopped` initially.

## Variables

Input variables are defined in `variables.tf`. Typical variables include:

| Variable Name         | Description                        | Default Value    |
|-----------------------|----------------------------------|------------------|
| `vpc_cidr`            | CIDR block for the VPC            | `"10.0.0.0/16"`  |
| `public_subnet_cidr`   | CIDR block for the public subnet  | `"10.0.1.0/24"`  |

You can override these defaults by creating a `terraform.tfvars` file or passing variables via CLI.

Example `variables.tf`: