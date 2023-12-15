terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = ">= 3.11.0"
    }
    elasticsearch = {
      source = "phillbaker/elasticsearch"
    }
  }
}