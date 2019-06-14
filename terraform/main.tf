module "security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name                = "http"
  description         = "http security group"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = {
    Environment = "dev"
  }
}

data "aws_ami" "centos7-valenciadevops" {
  most_recent = true

  name_regex = "^centos7-valenciadevops-*"
  owners     = ["610004488240"]
}


module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                        = "valenciadevops-instance"
  instance_count              = 3
  ami                         = data.aws_ami.centos7-valenciadevops.id
  instance_type               = var.instance_type
  monitoring                  = false
  vpc_security_group_ids      = [module.security_group.this_security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.app.id

  tags = {
    Environment = "dev"
  }
}
