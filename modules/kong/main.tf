module "kong" {
  source = "terraform-helm-release"

  name       = "kong"
  repository = "https://charts.konghq.com"
  chart      = "kong"
  namespace  = var.namespace

  values = {
    ingressController.installCRDs = false
    env.database                  = "off" # Use DB-less mode for local setup
    proxy.type                    = "NodePort"
  }
}

# Kong Plugins for Authentication
resource "kubernetes_manifest" "kong_key_auth" {
  manifest = yamldecode(file("${path.module}/kong_key_auth.yaml"))
}

# KongConsumer
resource "kubernetes_manifest" "kong_consumer" {
  manifest = yamldecode(file("${path.module}/kong_consumer.yaml"))
}

# KongCredential for API Key
resource "kubernetes_manifest" "kong_credential_key" {
  manifest = yamldecode(file("${path.module}/kong_credential_key.yaml"))
}

# Namespace Annotation for Linkerd Injection
resource "kubernetes_namespace" "kong_namespace" {
  metadata {
    name = var.namespace
    annotations = {
      "linkerd.io/inject" = "enabled"
    }
  }
}
