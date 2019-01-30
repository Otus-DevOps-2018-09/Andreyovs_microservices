variable project {
  description = "Project ID"
  default = "docker-965956"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable machine_type {
  description = "Machine type"
  default     = "g1-small"
}

variable disk_size {
  description = "Disk size"
  default     = "20"
}

variable initial_node_count {
  description = "Initial Node Count"
  default     = 3
}

variable gke_version {
  description = "GKE Version"
  default     = "1.10.11-gke.1"
}