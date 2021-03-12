# AWS Terraform Jenkins and Node Three Tier

The repo have the all the scripts to deploy Jenkins in AWS and all the scripts to deploy a three tier application test in NodeJS.

## Prerequisites

Terraform uses s3 bucket as the backend of its tfstate and Jenkins use the s3 bucket to save the reference of the AMI ID to use in the terraform workloas to deploy nodejs application.

```bash
aws s3api create-bucket --bucket node-aws-jenkins-terraform --region us-west-2 --create-bucket-configuration LocaltionContraint=us-west-2
```

##** Jenkins

To deploy Jenkins Server follow the belows steps. First execute the terraform scripts. 

**Note: Please check the Region and the AMI ID in the var.tf. By default use us-west-2 as Region and my public and private key, please change for you parameters**

```bash
cd jenkins/setup
terraform init
terraform plan
terraform apply
```

When finished the tasks, you must configure the tasks in jenkins server.

**** TBD details tasks ****

## Three Tier Application

The nodejs application has a web server (web directory), api server (api directory) aand AWD RDS deployed with terraform scripts. For execute manually the process firstly create the AMI with Packer.

1. Create Images with Packer

```bash
cd terraform
packer build -machine-readable packer-ami-web.json
packer build -machine-readable packer-ami-api.json
```

when the process finished two custom AMI you must found in the AWS EC2 console.

2. Create all infraestructure with terraform

You must need to create two files in terraform directory to indicate the AMI ID for both instance.

```bash
AMI_ID_API=<ARTIFACT API AMI ID CREATED IN 1>
echo 'variable "API_INSTANCE_AMI" { default = "'${AMI_ID_API}'" }' > amivar_api.tf

AMI_ID_WEB=<ARTIFACT WEB AMI ID CREATED IN 1>
echo 'variable "WEB_INSTANCE_AMI" { default = "'${AMI_ID_WEB}'" }' > amivar_api.tf
```

The next step is execute all the terrafom plan

```
terraform init
terraform play
terraform apply
```

When all the process finished the three tier application will be created. Check the ouput of the terraform apply to bring the ELB URL.







