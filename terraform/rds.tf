resource "aws_db_subnet_group" "postgres-subnet" {
  name        = "postgres-subnet"
  description = "RDS subnet group"
  subnet_ids  = ["${aws_subnet.main-private-1.id}", "${aws_subnet.main-private-2.id}"]
}

resource "aws_db_parameter_group" "postgres-parameters" {
  name        = "postgresdb-parameters"
  family      = "postgres9.6"
  description = "PostgresDB parameter group"
}


resource "aws_db_instance" "postgres" {
  allocated_storage       = 100
  engine                  = "postgres"
  engine_version          = "9.6.11"
  instance_class          = "db.t2.micro"
  identifier              = "postgresdb"
  name                    = "postgres"
  username                = "postgres"            # username
  password                = "${var.RDS_PASSWORD}" # password
  db_subnet_group_name    = "${aws_db_subnet_group.postgres-subnet.name}"
  parameter_group_name    = "${aws_db_parameter_group.postgres-parameters.name}"
  multi_az                = "false"
  vpc_security_group_ids  = ["${aws_security_group.allow-postgresdb.id}"]
  storage_type            = "gp2"
  backup_retention_period = 30
  skip_final_snapshot     = true

  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  tags {
    Name = "postgresdb-instance"
  }
}

resource "aws_security_group" "allow-postgresdb" {
  vpc_id      = "${aws_vpc.main.id}"
  name        = "allow-postgresdb"
  description = "allow-postgresdb"
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = ["${aws_security_group.api-instance.id}"] # allowing access from our api instance
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }
  tags {
    Name = "allow-postgresdb"
  }
}


output "rds-private-ip" {
  value = "${aws_db_instance.postgres.address}"
}
