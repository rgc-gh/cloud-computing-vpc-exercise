# cloud-computing-vpc-exercise

## Exercise

Mount a VPC with an Internet Gateway with two public subnets and a NAT Gateway. This VPC should connect via peering to a second VPC.

The second VPC should be able to ping one of the private subnets of the first VPC.

## Architecture

![architecture](./diagrams/architecture.drawio.png "Architecture").

## Usage

```bash
terraform init
terraform plan -var public_key_path=key.pub -var inbound_cidr_block="0.0.0.0/0"
terraform apply -var public_key_path=key.pub -var inbound_cidr_block="0.0.0.0/0"
```

## SSH

```bash
ssh-keygen -t rsa -b 2048 -f <key>
scp -i <key> <file> ubuntu@<ip>:~/
```
