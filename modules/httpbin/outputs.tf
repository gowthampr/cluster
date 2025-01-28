output "httpbin_service" {
  value = kubernetes_service.httpbin.metadata[0].name
}