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

data "aws_iam_instance_profile" "server_instance_profile" {
  name = var.server_instance_profile_name
}

resource "aws_instance" "prod_server" {
  ami                         = data.aws_ami.latest_ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.sg_ids
  associate_public_ip_address = var.associate_public_ip
  key_name                    = var.key_name

  iam_instance_profile = data.aws_iam_instance_profile.server_instance_profile.name
  tags = {
    Name = var.name
  }

  root_block_device {
    volume_size           = 40
    volume_type           = "gp3"
    encrypted             = true
    throughput            = 175
    delete_on_termination = true
  }

  lifecycle {
    ignore_changes = [
      ami,
      user_data,
    ]
  }
}

