
provider "aws" {
  # profile = local.profile
  region = "us-east-1"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}


# module "spicedb-operator" {
#   source                  = "./../"
#   spicedb-operator        = true
#   release_name            = "spicedb-operator"
#   namespace               = "spicedb-system"
#   values_file             = "${path.module}/values.yaml"
#   spicedb_cluster_enabled = true
#
#   spicedb_clusters = [
#     {
#       name = "dev-test"
#       config = {
#         replicas        = 1
#         datastoreEngine = "memory"
#         logLevel        = "debug"
#       }
#       secretName    = "dev-spicedb-config"
#       preshared_key = "averysecretpresharedkey123"
#       datastore_uri = "memory"
#     }
#   ]
# }

module "spicedb-operator" {
  source         = "./../"
  name           = "test"
  instance_class = "db.t3.micro"
  vpc_id         = "vpc-0a443368cc8b9a149" # add vpc id here
  subnet_ids     = ["subnet-03be56fd3c2156912", "subnet-0530b0a32e9b8b573"]
  password       = "" #if add some password
  allowed_ip     = ["0.0.0.0/0"]
  preshared_key  = "cnkcASMcisdkfiwujcf9IR"
}
