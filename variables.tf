#lables
variable "name" {
  type        = string
  default     = "spicedb-operator"
  description = "Name  (e.g. `app` or `cluster`)."
}

#networking
variable "allowed_ip" {
  type        = list(any)
  default     = []
  description = "List of allowed ip."
}

variable "allowed_ports" {
  type        = list(any)
  default     = [5432]
  description = "List of allowed ingress ports"
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "The ID of the VPC that the instance security group belongs to."
  sensitive   = true
}

variable "subnet_ids" {
  type        = list(string)
  default     = []
  description = "A list of VPC Subnet IDs to launch in."
}

variable "publicly_accessible" {
  type        = bool
  default     = false
  description = "Bool to control if instance is publicly accessible"
}
#storage
variable "allocated_storage" {
  type        = number
  default     = 50
  description = "The allocated storage in gigabytes"
}

#logs
variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  default     = ["postgresql", "upgrade"]
  description = "List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL)."
}
#database
variable "db_name" {
  type        = string
  default     = "spicedb"
  description = "The DB name to create. If omitted, no database is created initially"
}

variable "username" {
  type        = string
  default     = "postgres"
  description = "Username for the master DB user"
}


variable "password" {
  type        = string
  default     = ""
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
}

variable "instance_class" {
  type        = string
  default     = null
  description = "The instance type of the RDS instance"
}

variable "engine" {
  type        = string
  default     = "postgres"
  description = "The database engine to use for the RDS instance. Supported values: postgres, mysql, mariadb, etc."
}

variable "engine_name" {
  type        = string
  default     = "postgres"
  description = "The name of the database engine. Typically matches the engine type."
}

variable "engine_version" {
  type        = string
  default     = "17.4"
  description = "The version number of the database engine to use. For PostgreSQL, this specifies the exact version like 14.10."
}

variable "family" {
  type        = string
  default     = "postgres17"
  description = "The family of the DB parameter group. This should match the engine and major version (e.g., postgres14 for PostgreSQL 14)."
}

variable "major_engine_version" {
  type        = string
  default     = "17"
  description = "The major version of the database engine. Used for parameter group and option group configuration."
}

variable "multi_az" {
  type        = bool
  default     = false
  description = "Specifies if the RDS instance is multi-AZ enabled for high availability. When true, creates a standby replica in a different AZ."
}

variable "apply_immediately" {
  type        = bool
  default     = true
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window. When true, changes are applied immediately."
}

variable "deletion_protection" {
  type        = bool
  default     = true
  description = "If the DB instance should have deletion protection enabled. The database cannot be deleted when this value is set to true."
}

variable "ssm_parameter_endpoint_enabled" {
  type        = bool
  default     = false
  description = "Whether to create SSM parameters storing the database endpoint information. When enabled, creates parameters in AWS Systems Manager Parameter Store."
}

variable "storage_encrypted" {
  type        = bool
  default     = true
  description = "Specifies whether the DB instance is encrypted. It is highly recommended to enable encryption for data at rest security."
}

variable "backup_retention_period" {
  type        = number
  default     = 7
  description = "The number of days to retain automated backups. Values range from 0 (disable backups) to 35 days."
}

variable "backup_window" {
  type        = string
  default     = "03:00-06:00"
  description = "The daily time range during which automated backups are created if automated backups are enabled. Format: HH:MM-HH:MM"
}

variable "maintenance_window" {
  type        = string
  default     = "Mon:00:00-Mon:03:00"
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. UTC time."
}

variable "namespace" {
  type        = string
  default     = "spicedb"
  description = "namespace of spicedb-operator   (e.g. `tools` or `prod`)."
}

variable "spicedb-operator" {
  description = "Enable OpenTelemetry Collector deployment"
  type        = bool
  default     = false
}

variable "preshared_key" {
  type        = string
  default     = ""
  description = "Preshared key for SpiceDB authentication. If empty, a random key will be generated. This value is sensitive and should be kept secret."
  sensitive   = true
}

variable "replicas" {
  type    = number
  default = 2
}

variable "manage_master_user_password" {
  description = "Whether to allow RDS to manage the master user password in Secrets Manager"
  type        = bool
  default     = null
}