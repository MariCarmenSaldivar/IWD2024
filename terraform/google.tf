resource "google_cloud_run_v2_service" "default" {
  count = 1
  name     = "iwd-cloudrun-srv${count.index}"
  location = "us-central1"
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "index.docker.io/msaldivar/iwdimgdemo:${var.imagetag}"
    }
  }

  traffic {
    percent = 100
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
  }
}

resource "google_cloud_run_service_iam_binding" "binding" {
  count = 4
  location = google_cloud_run_v2_service.default[count.index].location
  service  = google_cloud_run_v2_service.default[count.index].name
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ] 
}
