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

variable "activate_latest_on_staging" {
  type    = bool
  default = true
}

variable "activate_latest_on_production" {
  type    = bool
  default = true
}

variable "dns_records" {
  default = {
    "orgigin1" = {
      zone       = "scriptclub.net"
      recordType = "A"
      ttl        = 60
      target     = "172.233.190.92"
      name       = "origin-www.scriptclub.net"
    },
    "origin2" = {
      zone       = "scriptclub.net"
      recordType = "A"
      ttl        = 100
      target     = "173.233.190.93"
      name       = "origin-api.scriptclub.net"
    },
    "origin3" = {
      zone       = "scriptclub.net"
      recordType = "A"
      ttl        = 600
      target     = "174.233.190.94"
      name       = "origin-blog.scriptclub.net"
    }
  }
}