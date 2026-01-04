variable "prefix_env" {
  description = "Predefined Environment"
  type = string
}

variable "subnet_id" {
    description = "Public Subnet ID"
    type = string
}

variable "web-sg" {
    description = "Web SG"
    type = string
}

variable "user_data" {
    description = "Shell Script"
    type = string
}