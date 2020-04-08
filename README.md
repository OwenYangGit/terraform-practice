# Terraform v0.12
For devops using terraform control japan platform infrastructure as code.
[Why terraform ?](https://blog.gruntwork.io/why-we-use-terraform-and-not-chef-puppet-ansible-saltstack-or-cloudformation-7989dad2865c)

## terraform-install.sh
- OS : ubuntu:18.04
- Need have zip tools ( sudo apt-get install zip -y )
- Base on $SHELL=BASH

### Configuration format documentation
[Reference](https://www.terraform.io/docs/configuration/index.html)

## terraform create resources step
1. cd vpc/
2. terraform init
3. terraform apply

### when you want to remove resources
:star: ` terraform destroy `
