provider "volterra" {
  api_p12_file = var.volterraP12
  url          = var.volterraUrl
  api_ca_cert  = var.volterraCaCert
}
