variable "public_key" {
  type = string
  default = ""
}

variable "region" {
  type = string
  default = "eu-central-1"
}

variable "ssh_user" {
  type = string
  default = "ubuntu"
}

variable "ssh_key_path" {
  type = string
  default = ""
}