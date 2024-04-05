resource "google_cloud_run_service" "default" {
  name     = "cloudrun-srv"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "index.docker.io/msaldivar/iwdimgdemo:main"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}