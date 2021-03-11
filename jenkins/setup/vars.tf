variable "AWS_REGION" {
  default = "us-west-2"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "/home/gonza/.ssh/id_rsa"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "/home/gonza/.ssh/id_rsa.pub"
}

variable "AMIS" {
  type = "map"

  default = {
    us-east-1 = "ami-042e8287309f5df03"
    us-west-2 = "ami-0ca5c3bd5a268e7db"
    eu-west-1 = "ami-08bac620dc84221eb"
  }
}

variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}

variable "JENKINS_VERSION" {
  default = "2.121.2"
}

variable "TERRAFORM_VERSION" {
  default = "0.11.10"
}

variable "APP_INSTANCE_COUNT" {
  default = "0"
}
