terraform {
  backend "gcs" {
    bucket = "bucket-andreyo-docker"
    prefix = "terraform/state"
  }
}
