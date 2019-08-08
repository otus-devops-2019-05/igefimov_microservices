variable project {
  description = "Project"
}

variable region {
  description = "Region"

  # Default value
  default = "europe-west1"
}

variable zone {
  description = "Zone where instance will be created"
  default     = "europe-west1-b"
}

variable instance_count {
  description = "Number of instances to start"
}

variable app_disk_image {
  description = "Disk image for VM where app is deployed"
  default     = "ubuntu-docker-img"
}

variable public_key_path {
  # Variable description
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  # Variable description
  description = "Path to the private key used by Provisioners(section in resource 'google_compute_instance' 'app') toconnect to the VM and do the job"
}

variable source_ranges {
  description = "Allowed IP addresses"
  default     = ["0.0.0.0/0"]
}

