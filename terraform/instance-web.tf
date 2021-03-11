data "template_file" "web-shell-script" {
  template = "${file("scripts/user-data-web.sh")}"
  vars {
    API_HOSTNAME = "${aws_elb.api-elb.dns_name}"
    API_PORT = "80"
    WEB_PORT = "${var.WEB_PORT}"
  }
}

resource "aws_security_group" "web-instance" {
  vpc_id = "${aws_vpc.main.id}"
  name = "allow-web-ssh"
  description = "security group that allows all egress traffic"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "${var.WEB_PORT}"
    to_port = "${var.WEB_PORT}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "web-instance"
  }
}

output "web-port" {
  value = "${var.WEB_PORT}"
}