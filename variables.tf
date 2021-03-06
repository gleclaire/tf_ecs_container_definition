variable "name" {
  description = "Name/name prefix to apply to the resources in the module"
}

variable "image" {
  description = "The docker image to use"
}

variable "cpu" {
  description = "The CPU limit for this container definition"
  default     = "256"
}

variable "memory" {
  description = "The memory limit for this container definition"
  default     = "256"
}

variable "container_port" {
  description = "App port to expose in the container"
  default     = "8080"
}

variable "container_env" {
  description = "Environment variables for this container"
  type        = "map"
  default     = {}
}

variable "labels" {
  description = "Labels to be applied to the docker container"
  type        = "map"
  default     = {}
}

variable "metadata" {
  description = "DEPRECATED - values passed to this variable will be ignored"
  type        = "map"
  default     = {}
}

variable "mountpoint" {
  description = "Mountpoint map with 'sourceVolume' and 'containerPath' and 'readOnly' (optional)."
  type        = "map"
  default     = {}
}
