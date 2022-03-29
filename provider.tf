
terraform {
  required_version = "~> 1.1.7"
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
  # Optional attributes and the defaults function are
  # both experimental, so we must opt in to the experiment.
  experiments = [module_variable_optional_attrs]
}
