terraform {
  required_version = "~> 1.4"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.11"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}