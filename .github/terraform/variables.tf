

# This file lists variables that you can set using the -var flag during "terraform apply".
# Example: terraform apply -var project_id="${PROJECT_ID}"

variable "project_id" {
  type        = string
  description = "The Google Cloud project ID."
}
