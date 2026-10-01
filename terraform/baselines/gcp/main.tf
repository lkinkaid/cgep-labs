# terraform/baselines/gcp/main.tf
terraform {
  required_version = ">= 1.6"
  required_providers {
    google = { source = "hashicorp/google", version = "~> 5.0" }
  }
}

provider "google" {
  project               = var.gcp_project
  region                = "us-central1"
  user_project_override = true
  billing_project       = var.gcp_project
}
