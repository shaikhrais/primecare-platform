# PrimeCare Master Backend Deployment
# This Terraform file orchestrates the deployment of all 17 Dart Microservices to Google Cloud Run.

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = "primecare-production"
  region  = "us-central1"
}

# Define local list of microservices
locals {
  services = [
    "auth-api",
    "billing-api",
    "client-api",
    "compliance-api",
    "franchise-reporting-api",
    "governance-api",
    "notes-api",
    "notification-api",
    "provider-api",
    "scheduling-api",
    "verification-api",
    "visit-api",
    "marketing-api",
    "support-api",
    "hr-api",
    "operations-api",
    "telemetry-api"
  ]
}

# Iterate over the list and create a Google Cloud Run service for each microservice
resource "google_cloud_run_service" "primecare_apis" {
  count    = length(local.services)
  name     = local.services[count.index]
  location = "us-central1"

  template {
    spec {
      containers {
        # Assumes Docker images have been pushed to Google Container Registry (GCR)
        image = "gcr.io/primecare-production/${local.services[count.index]}:latest"
        
        ports {
          container_port = 8080
        }

        env {
          name  = "DATABASE_URL"
          # In a real environment, this should point to Cloud SQL or your live PostgreSQL database
          value = "postgresql://user:password@live-db-host:5432/primecare?schema=public" 
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Allow public access to the APIs
resource "google_cloud_run_service_iam_member" "public_access" {
  count    = length(local.services)
  service  = google_cloud_run_service.primecare_apis[count.index].name
  location = google_cloud_run_service.primecare_apis[count.index].location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

output "api_urls" {
  description = "The deployed live URLs for all 17 backend microservices"
  value       = {
    for service in google_cloud_run_service.primecare_apis : service.name => service.status[0].url
  }
}
