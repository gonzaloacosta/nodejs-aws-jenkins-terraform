terraform {
  backend "s3" {
    bucket = "node-aws-jenkins-terraform-202103111200"
    key    = "jenkins.terraform.tfstate"
    region = "us-west-2"
  }
}
