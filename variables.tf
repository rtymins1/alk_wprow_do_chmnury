variable "vpc_name" {
  description = "name_of_vpc"
  type        = string

  default = "vpc-wprow-52334-1"
}
variable "subnet_name" {
  description = "name_of_subnet"
  type        = string

  default = "wprow-subnet-52334-us"
}
variable "fw_name" {
  description = "name_of_fw_ssh_http"
  type        = string

  default = "wprow-fw-52334-ssh-http"
}
variable "instance_count" {
  description = "amount of instances"
  type        = string

  default = "1"
}
variable "gcp_region" {
  description = "region gcp"
  type        = string

  default = "us-central1"
}
variable "gcp_zone" {
  description = "zona gcp"
  type        = string

  default = "us-central1-a"
}


