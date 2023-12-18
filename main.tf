resource "vault_database_secret_backend_connection" "this" {
  name                     = var.name
  backend                  = try(var.backend.path, var.backend)
  allowed_roles            = concat([for k, v in var.roles : v.name], var.allowed_roles)
  verify_connection        = var.verify_connection
  data                     = var.data
  root_rotation_statements = var.root_rotation_statements

  dynamic "elasticsearch" {
    for_each = var.elasticsearch[*]
    content {
      url      = elasticsearch.value.url
      username = elasticsearch.value.username
      password = elasticsearch.value.password
      insecure = elasticsearch.value.insecure
    }
  }

  dynamic "mongodbatlas" {
    for_each = var.mongodbatlas[*]
    content {
      private_key = mongodbatlas.value.private_key
      project_id  = mongodbatlas.value.project_id
      public_key  = mongodbatlas.value.public_key
    }
  }

  dynamic "mysql" {
    for_each = var.mysql[*]
    content {
      connection_url = mysql.value.connection_url
      username       = mysql.value.username
      tls_ca         = mysql.value.tls_ca
    }
  }

  dynamic "postgresql" {
    for_each = var.postgresql[*]
    content {
      connection_url = postgresql.value.connection_url
      username       = postgresql.value.username
    }
  }
}

resource "vault_generic_endpoint" "rotate_root" {
  count                = var.rotate_root ? 1 : 0
  path                 = "${vault_database_secret_backend_connection.this.backend}/rotate-root/${vault_database_secret_backend_connection.this.name}"
  ignore_absent_fields = true
  disable_read         = true
  disable_delete       = true
  data_json            = "{}"
  depends_on = [
    vault_database_secret_backend_connection.this
  ]
}

resource "vault_database_secret_backend_role" "this" {
  for_each            = var.roles
  name                = coalesce(each.value.name, each.key)
  backend             = vault_database_secret_backend_connection.this.backend
  db_name             = vault_database_secret_backend_connection.this.name
  creation_statements = each.value.creation_statements
  default_ttl         = each.value.default_ttl
}