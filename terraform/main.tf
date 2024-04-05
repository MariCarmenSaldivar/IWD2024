# The configuration for the `remote` backend.
terraform {
  backend "remote" {
    # The name of your Terraform Cloud organization.
    organization = "saldivar"

    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "iwd-test-us-east"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.97.1"
    }
  }
}

provider "google" {
  project = "iwd-2024-419319"
  region  = "us-central1"
  zone    = "us-central1-c"
}


resource "google_storage_bucket" "static_site" {
  name          = "iwdbucket"
  location      = "us-central1"
  force_destroy = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

# upload index.html page to bucket
resource "google_storage_bucket_object" "webpage_source" {
  name   = "index.html"
  source = "../staticweb/index.html"
  bucket = google_storage_bucket.static_site.name
}

# upload index.html page to bucket
resource "google_storage_bucket_object" "style_css" {
  name   = "index.html"
  source = "../staticweb/style.css"
  bucket = google_storage_bucket.static_site.name
}
# make the object publicly accessible
resource "google_storage_default_object_access_control" "public_rule_default" {
  # object = google_storage_bucket_object.webpage_source.name
  bucket = google_storage_bucket.static_site.name
  role   = "READER"
  entity = "allUsers"
}

output "website_url" {
  value = "http://${google_storage_bucket.static_site.name}.storage.googleapis.com"
}