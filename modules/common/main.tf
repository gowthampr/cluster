resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

output "namespace" {
  value = kubernetes_namespace.namespace.metadata[0].name
}
