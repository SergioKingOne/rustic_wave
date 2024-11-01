variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
}

variable "environment" {
  description = "The deployment environment (dev/prod)"
  type        = string
}

variable "bucket_name" {
  description = "The name of the storage S3 bucket"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the website"
  type        = string
  default     = "sergio-dev-projects.click"
}

# We'll uncomment this when we set up SSL
# variable "certificate_arn" {
#   description = "ARN of the SSL certificate"
#   type        = string
# }

variable "hosted_zone_id" {
  description = "The Route53 Hosted Zone ID"
  type        = string
}

variable "aws_access_key_id" {
  description = "AWS Access Key ID"
  type        = string
  sensitive   = true
}

variable "aws_secret_access_key" {
  description = "AWS Secret Access Key"
  type        = string
  sensitive   = true
}

variable "create_dns" {
  description = "Whether to create the DNS record"
  type        = bool
  default     = false
}
