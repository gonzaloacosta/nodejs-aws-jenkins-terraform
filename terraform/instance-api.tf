data "template_file" "api-shell-script" {
  template = "${file("scripts/user-data-api.sh")}"
  vars {
    PASSWORD    = "${var.RDS_PASSWORD}"
    DB_HOSTNAME = "${aws_db_instance.postgres.address}"
    PORT        = "${var.API_PORT}"
  }
}

resource "aws_security_group" "api-instance" {
  vpc_id      = "${aws_vpc.main.id}"
  name        = "allow-ssh"
  description = "security group that allows all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "${var.API_PORT}"
    to_port     = "${var.API_PORT}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "example-instance"
  }
}
