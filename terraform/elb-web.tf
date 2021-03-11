resource "aws_elb" "web-elb" {
  name            = "web-elb"
  subnets         = ["${aws_subnet.main-public-1.id}"]
  security_groups = ["${aws_security_group.elb-securitygroup.id}"]
  listener {
    instance_port     = "${var.WEB_PORT}"
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:${var.WEB_PORT}/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400
  tags {
    Name = "web-elb"
  }
}

output "WEB-ELB" {
  value = "${aws_elb.web-elb.dns_name}"
}
