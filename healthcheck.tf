resource "volterra_healthcheck" "openwebrx" {
  name      = format("%s-openwebrx", var.projectPrefix)
  namespace = var.namespace

  http_health_check {
    use_origin_server_name = true
    path                   = "/"
  }
  healthy_threshold   = 1
  interval            = 15
  timeout             = 1
  unhealthy_threshold = 2

}
