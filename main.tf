resource "helm_release" "spicedb-operator" {
  count            = var.spicedb-operator ? 1 : 0
  name             = var.release_name
  namespace        = var.namespace
  create_namespace = true
  repository = "https://bushelpowered.github.io/spicedb-operator-chart/"
  chart      = "spicedb-operator"
  values = var.values_file != "" ? [file(var.values_file)] : []

}


resource "kubernetes_secret" "spicedb_config" {
  count = var.spicedb_cluster_enabled ? length(var.spicedb_clusters) : 0

  metadata {
    name      = var.spicedb_clusters[count.index].secretName
    namespace = var.namespace
  }

  data = {
    preshared_key = var.spicedb_clusters[count.index].preshared_key
    datastore_uri = var.spicedb_clusters[count.index].datastore_uri
  }

  type       = "Opaque"
  depends_on = [helm_release.spicedb-operator]
}


resource "kubernetes_manifest" "spicedb_cluster" {
  count = var.spicedb_cluster_enabled ? length(var.spicedb_clusters) : 0

  manifest = {
    apiVersion = "authzed.com/v1alpha1"
    kind       = "SpiceDBCluster"
    metadata = {
      name      = var.spicedb_clusters[count.index].name
      namespace = var.namespace
    }
    spec = {
      config = {
        replicas        = var.spicedb_clusters[count.index].config.replicas
        datastoreEngine = var.spicedb_clusters[count.index].config.datastoreEngine
        logLevel        = var.spicedb_clusters[count.index].config.logLevel
      }
      secretName = var.spicedb_clusters[count.index].secretName
    }
  }

  depends_on = [helm_release.spicedb-operator, kubernetes_secret.spicedb_config]
}