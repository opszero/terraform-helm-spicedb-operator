<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace to deploy into | `string` | `"spicedb-system"` | no |
| <a name="input_release_name"></a> [release\_name](#input\_release\_name) | Helm release name | `string` | `"spicedb-operator"` | no |
| <a name="input_spicedb-operator"></a> [spicedb-operator](#input\_spicedb-operator) | Enable OpenTelemetry Collector deployment | `bool` | `false` | no |
| <a name="input_spicedb_cluster_enabled"></a> [spicedb\_cluster\_enabled](#input\_spicedb\_cluster\_enabled) | Whether to deploy SpiceDBCluster CRs | `bool` | `true` | no |
| <a name="input_spicedb_clusters"></a> [spicedb\_clusters](#input\_spicedb\_clusters) | n/a | <pre>list(object({<br/>    name          = string<br/>    config        = any<br/>    secretName    = string<br/>    preshared_key = string<br/>    datastore_uri = string<br/>  }))</pre> | `[]` | no |
| <a name="input_values_file"></a> [values\_file](#input\_values\_file) | Path to the values.yaml file | `string` | `""` | no |
## Resources

| Name | Type |
|------|------|
| [helm_release.spicedb-operator](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_manifest.spicedb_cluster](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_secret.spicedb_config](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_spicedb_clusters"></a> [spicedb\_clusters](#output\_spicedb\_clusters) | List of SpiceDB Clusters deployed |
| <a name="output_spicedb_operator_release"></a> [spicedb\_operator\_release](#output\_spicedb\_operator\_release) | Name and Namespace of the deployed SpiceDB Operator |
| <a name="output_spicedb_secrets"></a> [spicedb\_secrets](#output\_spicedb\_secrets) | Secrets created for each SpiceDB cluster |
# 🚀 Built by opsZero!

<a href="https://opszero.com"><img src="https://opszero.com/img/common/opsZero-Logo-Large.webp" width="300px"/></a>

[opsZero](https://opszero.com) provides software and consulting for Cloud + AI. With our decade plus of experience scaling some of the world’s most innovative companies we have developed deep expertise in Kubernetes, DevOps, FinOps, and Compliance.

Our software and consulting solutions enable organizations to:

- migrate workloads to the Cloud
- setup compliance frameworks including SOC2, HIPAA, PCI-DSS, ITAR, FedRamp, CMMC, and more.
- FinOps solutions to reduce the cost of running Cloud workloads
- Kubernetes optimized for web scale and AI workloads
- finding underutilized Cloud resources
- setting up custom AI training and delivery
- building data integrations and scrapers
- modernizing onto modern ARM based processors

We do this with a high-touch support model where you:

- Get access to us on Slack, Microsoft Teams or Email
- Get 24/7 coverage of your infrastructure
- Get an accelerated migration to Kubernetes

Please [schedule a call](https://calendly.com/opszero-llc/discovery) if you need support.

<br/><br/>

<div style="display: block">
  <img src="https://opszero.com/img/common/aws-advanced.png" alt="AWS Advanced Tier" width="150px" >
  <img src="https://opszero.com/img/common/aws-devops-competency.png" alt="AWS DevOps Competency" width="150px" >
  <img src="https://opszero.com/img/common/aws-eks.png" alt="AWS EKS Delivery" width="150px" >
  <img src="https://opszero.com/img/common/aws-public-sector.png" alt="AWS Public Sector" width="150px" >
</div>
<!-- END_TF_DOCS -->