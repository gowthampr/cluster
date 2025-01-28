terraform {
  # Shared settings for Terraform
  extra_arguments "common_vars" {
    commands = ["apply", "plan", "destroy", "init"]
    arguments = ["-var-file=../../common/variables.tf"]
  }
}

inputs = {
  namespace = "default"
}