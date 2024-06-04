variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  Project = "expense"
  Environment = "dev"
  Terraform = "true"
  Component = "acm"
}

variable "zone_id" {
  default = "Z03923121KRYC3VZBNNH0"
