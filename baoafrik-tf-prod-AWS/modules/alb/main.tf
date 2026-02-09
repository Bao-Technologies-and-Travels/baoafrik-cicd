# resource "aws_security_group" "alb_sg" {
#   name   = "${var.name}-alb-sg"
#   vpc_id = var.vpc_id
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_lb" "prod" {
#   name               = "${var.name}-prod-alb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.alb_sg.id]
#   subnets            = var.public_subnets
# }

# resource "aws_lb_target_group" "prod_tg" {
#   name        = "${var.name}-prod-tg"
#   port        = var.target_port
#   protocol    = "HTTP"
#   vpc_id      = var.vpc_id
#   target_type = "instance"
#   health_check {
#     path                = var.health_check_path
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     matcher             = "200-399"
#   }

# }

# resource "aws_lb_listener" "prod_http" {
#   load_balancer_arn = aws_lb.prod.arn
#   port              = 80
#   protocol          = "HTTP"
#   default_action {
#     type = "redirect"
#     redirect {
#       port        = "443"
#       protocol    = "HTTPS"
#       status_code = "HTTP_301"
#     }
#   }
# }

# resource "aws_lb_listener" "prod_https" {
#   load_balancer_arn = aws_lb.prod.arn
#   port              = 443
#   protocol          = "HTTPS"
#   certificate_arn   = var.prod_certificate_arn
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.prod_tg.arn
#   }
# }