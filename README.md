# Terraform 101

This is our first terraform project
Terraform is an orchestration pool, which will deploy AMIs into the cloud

It can use many providers and use different types of images & or provisioning

In our stack we have:
- Chef - configuration management
- Packer - creates immutable images of our machines

Using a 'main.tf' file we configured a:

- provider
- VPC
- Security Group
- Internet Gateway
- Route Table
- Route Table Associations
- Subnet
- Instance
- Shell command to be executed on the instance
