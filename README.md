# Terraform 101

This is our first terraform project
Terraform is an orchestration tool, which will deploy AMIs into the cloud

It can use many providers and use different types of images & or provisioning

In our stack we have:
- Chef - configuration management
- Packer - creates immutable images of our machines

## Using a 'main.tf' file we configured a:

- provider
- VPC
- Security Group
- Internet Gateway
- Route Table
- Route Table Associations
- Subnet
- NACL
- Instance
- Shell command to be executed on the instance

## modules
Modules allow you to separate concerns of instances

## setting mongo env variable:
1) create output of db instance private ip
2) create variable of db instance ip in app tier
3) add variable of db-ip in template command in app tier main.tf
4) edit the script to change the env variable and run the app
- cd /home/ubuntu/app
- export DB_HOST=mongodb://<privateipofdb>:27017/posts
- sudo npm install express mongoose ejs
- node app.js
- node seeds/seed.js
