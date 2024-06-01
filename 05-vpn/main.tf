resource "aws_key_pair" "vpn" {
  key_name   = "vpn"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH0aMsOb7V7VW+b2FqvSX5Z8Zl1W73P8JsvopDbXDerw"
}

module "vpn" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.environment}-bastion"

  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  subnet_id              = local.public_subnet_id
  ami = data.aws_ami.ami_info.id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-vpn"
    }
  )
}