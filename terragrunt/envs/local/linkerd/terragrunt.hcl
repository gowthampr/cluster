terraform {
  source = "../../../../modules/linkerd"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  namespace = "linkerd"
}
