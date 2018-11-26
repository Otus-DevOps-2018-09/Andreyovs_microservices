terraform {
  backend "gcs" {
    bucket = "bucket-andreyo"
    prefix = "terraform/state"
  }
}
