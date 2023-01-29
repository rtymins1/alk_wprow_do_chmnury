
resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name 
  auto_create_subnetworks = false
   }
 
 resource "google_compute_subnetwork" "public-subnetwork" {
  name          = var.subnet_name 
  ip_cidr_range = "10.0.1.0/24"
  region        = var.gcp_region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_instance" "wprow-vm" {
  count        = var.instance_count
  name         = "ckp-52334-${count.index}"
  machine_type = "f1-micro"
  zone         = var.gcp_zone

  tags = ["alk", "ckp52334", "http-server"]

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-minimal-2204-jammy-v20230124"
    }
  }
 network_interface {

    network = google_compute_network.vpc_network.id 
    access_config {
      // for public ip
    }
    subnetwork = google_compute_subnetwork.public-subnetwork.id
  }
    metadata_startup_script = data.template_file.apache.rendered
  allow_stopping_for_update = true
}
resource "google_compute_firewall" "allow_ssh_http" {
  name = var.fw_name
  allow {
    ports    = ["22","80"]
    protocol = "tcp"
  }
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
}

data "template_file" "apache" {
    template = "${file("${path.module}/template/install_apache.tpl")}"
  }