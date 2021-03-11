# AWS Terraform Jenkins and Node Three Tier

* Pre requisites

```bash
aws s3api create-bucket --bucket node-aws-jenkins-terraform --region us-west-2 --create-bucket-configuration LocaltionContraint=us-west-2
terraform init
terraform play
terraform apply
> yes
```
