# Deployment and service declaration to the cluster
## Source inspiration : https://github.com/shivalkarrahul/DevOps/blob/master/aws/terraform/terraform-kubernetes-deployment/nodejs-application/
## Majors subsetps :
# 1_ : Send a secret named "node2elastic" via 'kubectl' command line tool
# 2_ : Deploy our Docker image
# 3_ : Serve the NodeJS app : ecf-node-to-elastic
# 4_ : Done!! >:-)

resource "null_resource" "send_secrets" {
	
	  provisioner "local-exec" {
	    command = <<EOT
      kubectl create secret generic node2elastic \
      --from-file=CLOUDID=./secrets/CLOUDID.txt \
      --from-file=USERNAME=./secrets/USERNAME.txt \
      --from-file=PASSWORD=./secrets/PASSWORD.txt
      EOT
    }
	  
    triggers = {
	    "run_at" = timestamp()
	  }
}

resource "kubernetes_deployment" "this" {
  metadata {
    name      = "ecf-node-to-elastic"
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "ecf-node-to-elastic"
      }
    }

	  strategy {
      type = "Recreate"
    }

    template {
      metadata {
        labels = {
          app = "ecf-node-to-elastic"
	    	  name = "ecf-node-to-elastic"
        }
      }
      spec {
        container {
          image = "docker.io/themaire/nodejs_2_elastic:latest"
          name  = "ecf-node-to-elastic-container"

		      liveness_probe {
            tcp_socket {
              port = 10000
            }

            failure_threshold     = 3
            initial_delay_seconds = 3
            period_seconds        = 10
            success_threshold     = 1
            timeout_seconds       = 2
          }

          readiness_probe {
            tcp_socket {
              port = 10000
            }

            failure_threshold     = 1
            initial_delay_seconds = 10
            period_seconds        = 10
            success_threshold     = 1
            timeout_seconds       = 2
          }

          port {
            name           = "http"
            container_port = 10000
            protocol       = "TCP"
          }

          ####
          #@@@@@@ Using secrets sent by kubectl command line tool
          ####
          env {
            name = "CLOUDID"
            value_from {
              secret_key_ref {
                name = "node2elastic"
                key = "CLOUDID"
              }
            }
          }
          env {
            name = "USERNAME"
            value_from {
              secret_key_ref {
                name = "node2elastic"
                key = "USERNAME"
              }
            }
          }
          env {
            name = "PASSWORD"
            value_from {
              secret_key_ref {
                name = "node2elastic"
                key = "PASSWORD"
              }
            }
          }
        }
  	  }
    }
  }

  depends_on = [
	    null_resource.send_secrets,
	  ]

}

resource "kubernetes_service" "this" {
  metadata {
    name      = "ecf-node-to-elastic"
  }
  spec {
    selector = {
      app = kubernetes_deployment.this.spec.0.template.0.metadata.0.labels.app
    }
    type = "LoadBalancer"
    port {
      name        = "http"
      port        = 10000
      protocol    = "TCP"
      target_port = 10000
    }
  }
}
