variable "RDS_PASSWORD" {
  default = "somepassword"
}

variable "API_PORT" {
  default = "5432"
}

variable "WEB_PORT" {
  default = "8080"
}

variable "AWS_REGION" {
  default = "us-west-2"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}


variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-042e8287309f5df03"
    us-west-2 = "ami-0ca5c3bd5a268e7db"
    eu-west-1 = "ami-08bac620dc84221eb"
  }
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
