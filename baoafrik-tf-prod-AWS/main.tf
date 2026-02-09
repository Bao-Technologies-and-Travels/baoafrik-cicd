
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

# data "aws_route53_zone" "baoafrik" {
#   name         = var.prod_domain
#   private_zone = false
# }

resource "aws_security_group" "prod_sg" {
  name   = "${var.project}-prod-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# module "ec2_prod" {
#   source              = "./modules/ec2"
#   name                = "${var.project}-prod"
#   ami                 = data.aws_ami.latest_ubuntu.id
#   instance_type       = var.instance_type
#   subnet_id           = element(module.vpc.public_subnets, 0)
#   vpc_id              = module.vpc.vpc_id
#   associate_public_ip = true
#   key_name            = var.key_name
#   open_port           = var.backend_port
#   sg_ids              = [aws_security_group.prod_sg.id]
#   server_instance_profile_name = module.iam.server_instance_profile_name
# }

module "vpc" {
  source              = "./modules/vpc"
  vpc_name                = var.project
  vpc_cidr            = var.vpc_cidr
  azs                 = var.azs
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr

}

# module "route53_zone" {
#   source           = "./modules/route53-zone"
#   prod_domain      = var.prod_domain
#   prod_alb_dns     = ""
#   prod_alb_zone_id = ""
#   zone_id          = data.aws_route53_zone.baoafrik.zone_id
# }

# module "route53_records" {
#   source           = "./modules/route53-records"
#   prod_domain      = var.prod_domain
#   zone_id          = data.aws_route53_zone.baoafrik.zone_id
#   prod_server_ip   = module.ec2_prod.public_ip
# }


module "iam" {
  source                  = "./modules/iam"
  project                 = var.project
  server_role             = var.server_role
  server_instance_profile = var.server_instance_profile
  prod_bucket             = var.prod_bucket
  jenkins_policy          = var.jenkins_policy
  backend_s3_policy       = var.backend_s3_policy
}

data "aws_acm_certificate" "prod" {
  domain      = var.prod_domain
  statuses    = ["ISSUED"]
  most_recent = true
}


# module "alb_prod" {
#   source               = "./modules/alb"
#   name                 = "${var.project}-prod"
#   vpc_id               = module.vpc.vpc_id
#   public_subnets       = flatten(module.vpc.public_subnets)
#   public_subnet_id     = element(module.vpc.private_subnets, 0)
#   target_port          = var.backend_port
#   health_check_path    = "/health"
#   prod_certificate_arn = data.aws_acm_certificate.prod.arn
# }

module "rds_prod" {
  source          = "./modules/rds"
  name            = "${var.project}-prod"
  vpc_id          = module.vpc.vpc_id
  private_subnets = flatten(module.vpc.private_subnets)
  db_username     = var.db_username
  db_password     = var.db_password
}

module "bucket" {
  source      = "./modules/s3"
  prod_bucket = var.prod_bucket
}
