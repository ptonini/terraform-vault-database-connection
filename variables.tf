variable "name" {}

variable "backend" {}

variable "allowed_roles" {
  type    = list(string)
  default = ["*"]
}

variable "data" {
  type = map(string)
  default = {}
}

variable "root_rotation_statements" {
  type = set(string)
  default = null
}

variable "role_name_prefix" {
  default = "vault"
}

variable "verify_connection" {
  default = true
}

variable "rotate_root" {
  default = true
}

variable "elasticsearch" {
  type = object({
    url      = string
    username = string
    password = string
  })
  default = null
}

variable "mongodbatlas" {
  type = object({
    private_key = string
    project_id  = string
    public_key  = string
  })
  default = null
}

variable "mysql" {
  type = object({
    connection_url = string
    username       = string
    tls_ca         = string
  })
}

variable "postgresql" {
  type = object({
    connection_url = string
    username       = string
  })
  default = null
}