data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "staging_server" {
  ami                         = data.aws_ami.latest_ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.sg_ids
  associate_public_ip_address = true
  key_name                    = var.key_name

  iam_instance_profile = var.iam_instance_profile
  tags = {
    Name = var.name
  }

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    encrypted = true
    throughput = 175
    delete_on_termination = true
  }

  lifecycle {
    ignore_changes = [
      ami,
      user_data,
    ]
  }
}

