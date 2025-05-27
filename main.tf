resource "google_compute_network" "app" {
  name                    = "app"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "app" {
  name          = "app"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.app.id
}

data "google_compute_image" "ubuntu" {
  most_recent = true
  project     = "ubuntu-os-cloud" 
  family      = "ubuntu-2204-lts"
}

resource "google_compute_instance" "web" {
  name         = "web"
  machine_type = "e2-micro"

  
  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
    }
  }
  network_interface {
   subnetwork = "default"
   access_config {
      # Leave empty for dynamic public IP
    }
  }  

}
