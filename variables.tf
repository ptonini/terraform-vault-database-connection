variable "name" {}

variable "backend" {}

variable "allowed_roles" {
  type    = list(string)
  default = []
  nullable = false
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
    insecure = optional(bool)
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
  default = null
}

variable "postgresql" {
  type = object({
    connection_url = string
    username       = string
  })
  default = null
}

variable "roles" {
  type = map(object({
    name                = optional(string)
    backend             = string
    db_name             = string
    creation_statements = list(string)
    default_ttl         = optional(number)
  }))
  default = {}
  nullable = false
}