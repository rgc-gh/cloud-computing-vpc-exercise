resource "aws_security_group" "this" {
  name        = "sg-${var.name_suffix}"
  description = "Security group that allows SSH inbound and all outbound."
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    {
      Name = "sg-${var.name_suffix}"
    },
    var.tags
  )
}

resource "aws_instance" "instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.this.id]

  user_data = var.user_data

  tags = merge(
    {
      Name = "ec2-${var.name_suffix}"
    },
    var.tags
  )
}
