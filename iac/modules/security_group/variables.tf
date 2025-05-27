variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "security_group_name" {
  type = string
}

variable "description" {
  type = string
}

variable "aws_vpc_id" {
  type = string
}

variable "security_group_rules" {
  description = <<EOF
    list(object({
      type        = string
      to_port     = number
      protocol    = string
      from_port   = number
      cidr_blocks = optional(list(string))
      self        = optional(bool)
    }))
  EOF
}
