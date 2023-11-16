resource "kubernetes_namespace" "kasten" {
  metadata {
    name = "kasten-io"
  }
}

resource "helm_release" "kasten" {
  name       = "k10"
  repository = "https://charts.kasten.io"
  chart      = "k10"
  namespace  = kubernetes_namespace.kasten.metadata[0].name

  set {
    name  = "secrets.googleApiKey"
    value = google_secret_manager_secret.secret-basic.secret_id
  }

  set {
    name  = "secrets.googleProjectId"
    value = google_secret_manager_secret.secret-basic.project
  }

  set {
    name  = "auth.tokenAuth.enabled"
    value = true
  }
  set {
    name  = "externalGateway.create"
    value = true
  }
}

