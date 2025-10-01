module "postgresql" {
  source                          = "git::https://github.com/opszero/terraform-aws-rds.git?ref=v1.0.2"
  name                            = var.name
  allowed_ip                      = var.allowed_ip
  allowed_ports                   = var.allowed_ports
  vpc_id                          = var.vpc_id
  subnet_ids                      = var.subnet_ids
  publicly_accessible             = var.publicly_accessible
  allocated_storage               = var.allocated_storage
  storage_encrypted               = var.storage_encrypted
  backup_retention_period         = var.backup_retention_period
  backup_window                   = var.backup_window
  maintenance_window              = var.maintenance_window
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  db_name                         = var.db_name
  db_username                     = var.username
  password                        = var.password
  port                            = "5432"
  instance_class                  = var.instance_class
  engine                          = var.engine
  engine_name                     = var.engine_name
  engine_version                  = var.engine_version
  family                          = var.family
  major_engine_version            = var.major_engine_version
  multi_az                        = var.multi_az
  apply_immediately               = var.apply_immediately
  deletion_protection             = var.deletion_protection
  ssm_parameter_endpoint_enabled  = var.ssm_parameter_endpoint_enabled
  manage_master_user_password     = var.manage_master_user_password

}

resource "kubernetes_namespace" "spicedb" {
  depends_on = [module.postgresql]
  metadata {
    name = "spicedb"
  }
}

data "http" "spicedb_bundle" {
  url = "https://github.com/authzed/spicedb-operator/releases/latest/download/bundle.yaml"
}
locals {
  documents = [for doc in split("---", data.http.spicedb_bundle.response_body) : doc if trimspace(doc) != ""]
}

resource "kubectl_manifest" "spicedb_operator" {
  for_each = { for idx, doc in local.documents : idx => doc }

  yaml_body         = each.value
  server_side_apply = true
  depends_on        = [kubernetes_namespace.spicedb]
}


resource "kubectl_manifest" "dispatch_selfsigned_issuer" {
  depends_on = [kubernetes_namespace.spicedb, kubectl_manifest.spicedb_operator]

  yaml_body = <<-YAML
    apiVersion: cert-manager.io/v1
    kind: ClusterIssuer
    metadata:
      name: dispatch-selfsigned-issuer
    spec:
      selfSigned: {}
  YAML

  server_side_apply = true
}

resource "kubectl_manifest" "dispatch_ca_cert" {
  depends_on = [
    kubernetes_namespace.spicedb,
    kubectl_manifest.spicedb_operator,
    kubectl_manifest.dispatch_selfsigned_issuer
  ]

  yaml_body = <<-YAML
    apiVersion: cert-manager.io/v1
    kind: Certificate
    metadata:
      name: dispatch-ca
      namespace: spicedb
    spec:
      isCA: true
      commonName: ${var.name}.spicedb
      dnsNames:
        - ${var.name}.spicedb
      secretName: dispatch-root-secret
      privateKey:
        algorithm: ECDSA
        size: 256
      issuerRef:
        name: dispatch-selfsigned-issuer
        kind: ClusterIssuer
        group: cert-manager.io
  YAML

  server_side_apply = true
}

resource "kubectl_manifest" "dispatch_ca_issuer" {
  depends_on = [
    kubernetes_namespace.spicedb,
    kubectl_manifest.spicedb_operator,
    kubectl_manifest.dispatch_ca_cert
  ]

  yaml_body = <<-YAML
    apiVersion: cert-manager.io/v1
    kind: Issuer
    metadata:
      name: my-ca-issuer
      namespace: spicedb
    spec:
      ca:
        secretName: dispatch-root-secret
  YAML

  server_side_apply = true
}

resource "kubectl_manifest" "spicedb_cluster" {
  depends_on = [
    kubernetes_namespace.spicedb,
    kubectl_manifest.spicedb_operator,
    kubectl_manifest.dispatch_ca_cert
  ]

  yaml_body = <<-YAML
    apiVersion: authzed.com/v1alpha1
    kind: SpiceDBCluster
    metadata:
      name: spicedb
      namespace: spicedb
    spec:
      config:
        datastoreEngine: postgres
        replicas: ${var.replicas}
        dispatchUpstreamCASecretName: dispatch-root-secret
        dispatchClusterTLSCertPath: "/etc/dispatch/tls.crt"
        dispatchClusterTLSKeyPath: "/etc/dispatch/tls.key"
      secretName: spicedb-config
      patches:
        - kind: Deployment
          patch:
            spec:
              template:
                spec:
                  containers:
                    - name: spicedb
                      volumeMounts:
                        - name: custom-dispatch-tls
                          readOnly: true
                          mountPath: "/etc/dispatch"
                  volumes:
                    - name: custom-dispatch-tls
                      secret:
                        secretName: dispatch-root-secret
  YAML

  server_side_apply = true
}

resource "kubectl_manifest" "spicedb_config_secret" {
  depends_on = [
    kubernetes_namespace.spicedb,
    kubectl_manifest.spicedb_operator
  ]

  yaml_body = <<-YAML
    apiVersion: v1
    kind: Secret
    type: Opaque
    metadata:
      name: spicedb-config
      namespace: spicedb
    stringData:
      preshared_key: ${var.preshared_key}
      # If your password can contain special characters, urlencode it.
      # Example uses urlencode(); remove it if you don't need it.
      datastore_uri: "postgresql://${var.username}:${var.password}@${module.postgresql.db_instance_address}:5432/spicedb"
  YAML

  server_side_apply = true
}
