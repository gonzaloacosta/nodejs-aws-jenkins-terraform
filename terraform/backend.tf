terraform {
  backend "s3" {
    bucket = "node-aws-jenkins-terraform-202103111200"
    key    = "node-aws-jenkins-terraform.tfstate"
    region = "us-west-2"
  }
}
