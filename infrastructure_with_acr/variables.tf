variable "prefix" {
  type        = string
  description = "The prefix used for all resources in this example"
  default     = "amartsavy-demo-tf-sh-acr"
}

variable "location" {
  type        = string
  description = "The Azure location where all resources in this example should be created"
  default     = "East US"
}

variable "image" {
  type        = string
  description = "Full name with tag of the docker image in the public docker hub"
  default     = "amartsavy/my-sh-app:1.0"
}