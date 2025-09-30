output "spicedb_operator_release" {
  description = "Name and Namespace of the deployed SpiceDB Operator"
  value = {
    name      = try(helm_release.spicedb-operator[0].name, null)
    namespace = try(helm_release.spicedb-operator[0].namespace, null)
  }
}

output "spicedb_secrets" {
  description = "Secrets created for each SpiceDB cluster"
  value = [
    for s in kubernetes_secret.spicedb_config : {
      name      = s.metadata[0].name
      namespace = s.metadata[0].namespace
    }
  ]
}

output "spicedb_clusters" {
  description = "List of SpiceDB Clusters deployed"
  value = [
    for c in var.spicedb_clusters : {
      name      = c.name
      namespace = var.namespace
      replicas  = c.config.replicas
      engine    = c.config.datastoreEngine
      log_level = c.config.logLevel
    }
  ]
}
