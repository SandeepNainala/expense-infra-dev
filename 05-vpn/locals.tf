locals {
  public_subnet_id = element(split(",", data.aws_ssm_parameter.public_sg_ids.value),0)
  # convert StringList to list and get first element
}