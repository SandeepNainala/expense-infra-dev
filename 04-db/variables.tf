variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Project = "expense"
    Environment = "dev"
    terraform = "true"
  }
}

variable "zone_name" {
  default = "devops71.cloud"
}