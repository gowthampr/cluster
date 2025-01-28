resource "kubernetes_namespace" "linkerd_namespace" {
  metadata {
    name = var.namespace
  }
}

module "linkerd_crds" {
  source = "terraform-helm-release"

  name       = "linkerd-crds"
  repository = "https://helm.linkerd.io/stable"
  chart      = "linkerd-crds"
  namespace  = var.namespace
}

module "linkerd" {
  source = "terraform-helm-release"

  name       = "linkerd"
  repository = "https://helm.linkerd.io/stable"
  chart      = "linkerd2"
  namespace  = var.namespace
}