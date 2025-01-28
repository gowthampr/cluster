resource "kubernetes_namespace" "httpbin_namespace" {
  metadata {
    name = var.namespace
    annotations = {
      "linkerd.io/inject" = "enabled"
    }
  }
}

resource "kubernetes_deployment" "httpbin" {
  metadata {
    name      = "httpbin"
    namespace = kubernetes_namespace.httpbin_namespace.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "httpbin"
      }
    }

    template {
      metadata {
        labels = {
          app = "httpbin"
        }
      }

      spec {
        container {
          image = "kennethreitz/httpbin"
          name  = "httpbin"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "httpbin" {
  metadata {
    name      = "httpbin"
    namespace = kubernetes_namespace.httpbin_namespace.metadata[0].name
  }

  spec {
    selector = {
      app = "httpbin"
    }

    port {
      port        = 80
      target_port = 80
    }
  }
}
