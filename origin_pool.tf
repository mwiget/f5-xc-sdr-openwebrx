resource "volterra_origin_pool" "openwebrx" {
  name                   = format("%s-openwebrx", var.projectPrefix)
  namespace              = var.namespace
  endpoint_selection     = "LOCAL_PREFERRED"
  loadbalancer_algorithm = "LB_OVERRIDE"
  port                   = 80
  no_tls                 = true

  origin_servers {
    k8s_service {
      service_name  = "frontend.openwebrx"
      vk8s_networks = true
      site_locator {
        site {
          name      = var.siteName
          namespace = "system"
        }
      }
    }
  }
  healthcheck {
    name = format("%s-openwebrx", var.projectPrefix)
  }
}
