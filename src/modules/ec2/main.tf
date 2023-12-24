# Key Pairs
resource "aws_key_pair" "this" {
  key_name   = "key-${var.name_suffix}"
  public_key = file(var.public_key_path)

  tags = merge(
    {
      Name = "key-${var.name_suffix}"
    },
    var.tags
  )
}

# Security Groups
resource "aws_security_group" "this" {
  description = "Security group that allows SSH and ICMP inbound and all outbound."
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.inbound_cidr_blocks
  }

  ingress {
    description = "ICMP (ping)"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.inbound_cidr_blocks
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

resource "aws_instance" "this" {
  ami                         = var.ami
  associate_public_ip_address = var.associate_public_ip_address
  instance_type               = var.instance_type

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.this.id]
  key_name               = aws_key_pair.this.key_name

  user_data = var.user_data

  tags = merge(
    {
      Name = "ec2-${var.name_suffix}"
    },
    var.tags
  )
}
