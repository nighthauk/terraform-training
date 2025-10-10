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