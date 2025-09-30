provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}


module "spicedb-operator" {
  source                  = "./../"
  spicedb-operator        = true
  release_name            = "spicedb-operator"
  namespace               = "spicedb-system"
  values_file             = "${path.module}/values.yaml"
  spicedb_cluster_enabled = true

  spicedb_clusters = [
    {
      name = "dev-test"
      config = {
        replicas        = 1
        datastoreEngine = "memory"
        logLevel        = "debug"
      }
      secretName    = "dev-spicedb-config"
      preshared_key = "averysecretpresharedkey123"
      datastore_uri = "memory"
    }
  ]
}
