variable "edgerc_path" {
  description = "Path to the .edgerc file"
  type        = string
  default     = "~/.edgerc"
}

variable "config_section" {
  description = "Section in the .edgerc file to use"
  type        = string
  default     = "terraform"
}

variable "environment" {
  type    = string
  default = "dev"
  validation {
    condition = can(index(["dev", "prod"], var.environment))
    error_message = "Invalid value for environment. Allowed values are dev or prod."
  }
}

variable "ab_test" {
  description = "Origin A/B Test"
  type        = string
  default     = "B"
}

variable "apps" {
  default = [ "tf-scriptclub", "tf-api-scriptclub", "tf-www-scriptclub" ]
}