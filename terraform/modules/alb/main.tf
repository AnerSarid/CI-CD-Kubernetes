resource "aws_lb" "this" {
  name               = "${var.name}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnets

  enable_deletion_protection = false
  enable_http2               = true

}


resource "aws_lb_target_group" "this" {
  name     = "${var.name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }

}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_security_group" "alb" {
  name        = "alb-security-group"
  description = "Allow access to ALB"
  vpc_id      = var.vpc_id

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-security-group"
  }
}

resource "aws_lb_target_group_attachment" "this" {
  count            = length(data.aws_instances.eks_nodes.ids)
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = element(data.aws_instances.eks_nodes.ids, count.index)
  port             = 80
}

data "aws_instances" "eks_nodes" {
  filter {
    name   = "tag:eks:nodegroup-name"
    values = [var.eks_nodegroup_name]
  }
  filter {
    name   = "instance-state-name"
    values = ["running"]
  }
}



eksctl utils associate-iam-oidc-provider --region eu-central-1 --cluster develop-eks-project --approve

eksctl create iamserviceaccount \
  --cluster=develop-eks-project \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --attach-policy-arn=arn:aws:iam::553667535636:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve


helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=develop-eks-project --set serviceAccount.create=false --set region=eu-central-1 --set vpcId=vpc-051bbfbf751f0c704 --set serviceAccount.name=aws-load-balancer-controller

kubectl get pods -n kube-system

