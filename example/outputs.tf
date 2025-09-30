output "operator_info" {
  value = module.spicedb-operator.spicedb_operator_release
}

output "secrets_info" {
  value = module.spicedb-operator.spicedb_secrets
}

output "clusters_info" {
  value = module.spicedb-operator.spicedb_clusters
}
