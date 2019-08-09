terraform {
  #  required_version = "0.11.7"  #  required_version = "0.11.13"
}

provider "google" {
  version = "2.0.0"
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_instance" "app" {
  name         = "docker-host-${count.index}"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  count = "${var.instance_count}"

  tags = [
    "docker-host",
  ]

  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {}
  }

  metadata {
    ssh-keys = "gcp:${file(var.public_key_path)}"
  }

  # Here we define Provisioners and how they connect to the VM(protocol, credentials)
  connection {
    type        = "ssh"
    user        = "gcp"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }
}

resource "google_compute_firewall" "firewall_ssh" {
  name        = "default-allow-ssh-to-any-vm"
  description = "Allow SSH to any VM"
  network     = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["${var.source_ranges}"]
}


resource "google_compute_firewall" "firewall_port_9292" {
  name        = "default-allow-port-9292"
  description = "Allow port 9292 for every VM"
  network     = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["${var.source_ranges}"]
}
