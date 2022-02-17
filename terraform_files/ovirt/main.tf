terraform {
  required_providers {
    ovirt = {
      source = "ovirt/ovirt"
    }
  }
}

provider "ovirt" {
  url           = var.ovirt_fqdn
  username      = var.ovirt_username
  password      = var.ovirt_password
  tls_ca_bundle = var.ovirt_ca_bundle
  tls_insecure  = var.ovirt_insecure
}

data "ovirt_cluster" "cluster" {
  id  = var.ovirt_cluster_id
}

data "ovirt_storage_domain" "storage_domain" {
  id       = var.ovirt_storage_domain_id
  name     = var.ovirt_storage_domain_name
  cluster_id = data.ovirt_cluster
}

data "ovirt_network" "network" {
  name       = var.ovirt_network
  cluster_id = data.ovirt_cluster
}

data "ovirt_vnic_profile" "vnic"{
  name         = var.ovirt_vnic_profile
  cluster_id   = data.ovirt_cluster
}

locals {
  isISOExist = var.iso_download_path != "" && var.iso_download_path != null
}

# Uploading the ISO file
resource "ovirt_iso_file" "ISO_UPLOAD" {
  # upload the ISO file only if exist in the path
  count            = local.isISOExist ? 1 : 0
  storage_domain   = var.ovirt_storage_domain_id
  source_file      = var.iso_download_path
  destination_file = ${basename(var.iso_download_path)}
}

# Creating the master VMs
resource "vsphere_virtual_machine" "vm" {
  count = var.masters_count

  name                        = "${var.cluster_name}-master-${count.index}"
  cluster_id                  = data.ovirt_cluster.cluster.id
  num_cpus                    = var.master_vcpu
  memory                      = var.master_memory
  # no network before booting from the ISO file
  wait_for_vm_net_routable = local.isISOExist
  wait_for_vm_net_timeout  = local.isISOExist ? 5 : 0

  network_interface {
    network_id         = data.ovirt_network.network.name
    ovirt_vnic_profile = data.ovirt_vnic_profile.vnic.name
  }

  disk {
    name             = "master-${count.index}-disk-0"
    size             = var.master_disk_size_gib
    storage_domain   = data.ovirt_storage_domain.storage_domain.name
    thin_provisioned = true
  }

  dynamic "cdrom" {
    # create the cdrom device only if the iso file is available
    for_each = local.isISOExist ? [1] : []
    content {
      storage_domain = data.ovirt_storage_domain.storage_domain.id
      source         = local.isISOExist ? ovirt_iso_file.ISO_UPLOAD[0].destination_file : null
    }
  }
}
