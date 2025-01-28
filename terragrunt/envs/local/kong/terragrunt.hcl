terraform {
  source = "../../../../modules/kong"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  namespace = "kong"
}
