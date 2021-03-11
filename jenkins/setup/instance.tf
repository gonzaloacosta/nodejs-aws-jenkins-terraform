resource "aws_instance" "jenkins-instance" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = "${aws_subnet.main-public-1.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.jenkins-securitygroup.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"

  # user data
  user_data = "${data.template_cloudinit_config.cloudinit-jenkins.rendered}"

  iam_instance_profile = "${aws_iam_instance_profile.Jenkins-iam-role-instanceprofile.name}"
}

resource "aws_ebs_volume" "jenkins-data" {
  availability_zone = "us-west-2a"
  size              = 20
  type              = "gp2"

  tags {
    Name = "jenkins-data"
  }
}

resource "aws_volume_attachment" "jenkins-data-attachment" {
  device_name  = "${var.INSTANCE_DEVICE_NAME}"
  volume_id    = "${aws_ebs_volume.jenkins-data.id}"
  instance_id  = "${aws_instance.jenkins-instance.id}"
  skip_destroy = true
}

output "jenkins-ip" {
  value = ["${aws_instance.jenkins-instance.*.public_ip}"]
}
