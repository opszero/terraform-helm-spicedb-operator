variable "spicedb-operator" {
  description = "Enable OpenTelemetry Collector deployment"
  type        = bool
  default     = false
}

variable "release_name" {
  description = "Helm release name"
  type        = string
  default     = "spicedb-operator"
}

variable "namespace" {
  description = "Kubernetes namespace to deploy into"
  type        = string
  default     = "spicedb-system"
}

variable "values_file" {
  description = "Path to the values.yaml file"
  type        = string
  default     = ""
}

# SpiceDBCluster deployment
variable "spicedb_cluster_enabled" {
  description = "Whether to deploy SpiceDBCluster CRs"
  type        = bool
  default     = true
}

variable "spicedb_clusters" {
  type = list(object({
    name          = string
    config        = any
    secretName    = string
    preshared_key = string
    datastore_uri = string
  }))
  default = []
}

