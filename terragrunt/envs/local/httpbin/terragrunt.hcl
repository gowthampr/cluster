terraform {
  source = "../../../../modules/httpbin"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  namespace = "httpbin"
}
