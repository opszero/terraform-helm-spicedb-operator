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

<a href="https://opszero.com"><img src="https://opszero.com/wp-content/uploads/2024/07/opsZero_logo_svg.svg" width="300px"/></a>

Since 2016 [opsZero](https://opszero.com) has been providing Kubernetes
expertise to companies of all sizes on any Cloud. With a focus on AI and
Compliance we can say we seen it all whether SOC2, HIPAA, PCI-DSS, ITAR,
FedRAMP, CMMC we have you and your customers covered.

We provide support to organizations in the following ways:

- [Modernize or Migrate to Kubernetes](https://opszero.com/solutions/modernization/)
- [Cloud Infrastructure with Kubernetes on AWS, Azure, Google Cloud, or Bare Metal](https://opszero.com/solutions/cloud-infrastructure/)
- [Building AI and Data Pipelines on Kubernetes](https://opszero.com/solutions/ai/)
- [Optimizing Existing Kubernetes Workloads](https://opszero.com/solutions/optimized-workloads/)

We do this with a high-touch support model where you:

- Get access to us on Slack, Microsoft Teams or Email
- Get 24/7 coverage of your infrastructure
- Get an accelerated migration to Kubernetes

Please [schedule a call](https://calendly.com/opszero-llc/discovery) if you need support.

<br/><br/>

<div style="display: block">
  <img src="https://opszero.com/wp-content/uploads/2024/07/aws-advanced.png" width="150px" />
  <img src="https://opszero.com/wp-content/uploads/2024/07/AWS-public-sector.png" width="150px" />
  <img src="https://opszero.com/wp-content/uploads/2024/07/AWS-eks.png" width="150px" />
</div>
<!-- END_TF_DOCS -->