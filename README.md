# cloud-computing-vpc-exercise

## Exercise

Mount a VPC with an Internet Gateway with two public subnets and a NAT Gateway. This VPC should connect via peering to a second VPC.

The second VPC should be able to ping one of the private subnets of the first VPC.

## Solution

See the architecture [diagram](./diagrams/architecture.drawio.png).

## Test

```bash
terraform init
terraform validate
terraform plan -var-file="sample.tfvars"
```

### sample.tfvars

```hcl
region = "us-east-1"

cidr = {
  # 10.0.0.0/16, 10.10.0.0/16, 10.20.0.0/16, etc.
  block_spec = "10.%d.0.0/16"
  increment  = 10
}

vpcs = [
  {
    # Public VPC
    has_internet_gateway = true
    subnets = [
      {
        # Public subnet with NAT
        availability_zone_index    = 0,
        routes_to_internet_gateway = true,
        has_nat_gateway            = true,
        nat_gateway_subnet_index   = null
      },
      {
        # Private subnet
        availability_zone_index    = 0,
        routes_to_internet_gateway = false,
        has_nat_gateway            = false,
        nat_gateway_subnet_index   = 0
      },
      {
        # Public subnet
        availability_zone_index    = 1,
        routes_to_internet_gateway = true,
        has_nat_gateway            = false,
        nat_gateway_subnet_index   = null
      },
      {
        # Private subnet
        availability_zone_index    = 1,
        routes_to_internet_gateway = false,
        has_nat_gateway            = false,
        nat_gateway_subnet_index   = 0
      }
    ]
  },
  {
    # Private VPC
    has_internet_gateway = false
    subnets = [
      {
        # Private subnet
        availability_zone_index    = 0,
        routes_to_internet_gateway = false,
        has_nat_gateway            = false,
        nat_gateway_subnet_index   = null
      }
    ]
  }
]
```
