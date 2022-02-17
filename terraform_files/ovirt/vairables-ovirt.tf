//////
// oVirt variables
//////

variable "ovirt_fqdn" {
  type        = string
  description = "oVirt engine fqdn or server ip address"
}

variable "ovirt_username" {
  type        = string
  description = "The name of user to access oVirt Engine API"
}

variable "ovirt_password" {
  type        = string
  description = "The plain password of user to access Engine API"
}

variable "ovirt_cluster_id" {
  type        = string
  description = "oVirt cluster id"
}

variable "ovirt_ca_bundle" {
  type        = string
  description = "The CA certificate for the oVirt engine API in PEM format"
}

variable "ovirt_insecure" {
  type        = bool
  description = "Disable oVirt engine certificate verification"
  default     = false
}

variable "ovirt_storage_domain_id" {
  type        = string
  description = "The ID of the storage domain for the selected oVirt cluster"
}

variable "ovirt_storage_domain_name" {
  type = string
  description = "The name of the storage domain for the selected oVirt cluster"
}

variable "ovirt_network" {
  type        = string
  description = "The name of Logical Network for the selected oVirt cluster"
  default     = "ovirtmgmt"
}

variable "ovirt_vnic_profile" {
  type        = string
  description = "The ID of the vNIC profile of Logical Network"
}

///////////
// Test infra variables
///////////


variable "cluster_name" {
  type = string
  description = <<EOF
AI cluster name
All the resources will be located under a folder with this name
and tagged with the cluster name
The resources should be associate with this name for easy recognition.
EOF
}

variable "iso_download_path" {
  type        = string
  description = "The ISO path (We have to upload this file to the oVirt engine)"
  default = ""
}

///////////
// Control Plane machine variables
///////////

variable "masters_count" {
  type = string
  default = "3"
  description = "The number of master nodes to be created."
}

variable "master_memory" {
  type = number
  default = 16984
  description = "The size of the master's virtual machine's memory, in MB"
}

variable "master_disk_size_gib" {
  type = number
  default = 120
  description = "The size of the master's disk, in GB"
}

variable "master_vcpu" {
  type = number
  default = 4
  description = "The total number of virtual processor cores to assign to the master virtual machine."
}

variable "workers_count" {
  type = string
  default = "2"
  description = "The number of worker nodes to be created."
}

variable "worker_memory" {
  type = number
  default = 16984
  description = "The size of the worker's virtual machine's memory, in MB"
}

variable "worker_disk_size_gib" {
  type = number
  default = 120
  description = "The size of the worker's disk, in GB"
}

variable "worker_vcpu" {
  type = number
  default = 4
  description = "The total number of virtual processor cores to assign to the master virtual machine."
}
