variable "namespace" {
  description = "namespace"
  type        = string
  default     = "default"
}
variable "projectPrefix" {
  description = "project prefix for object names"
  type        = string
  default     = "myproject"
}
variable "fqdn" {
  description = "FQDN under with the service will be published"
  type        = string
  default     = ""
}
variable "serviceName" {
  description = "k8s service name plus namespace, concatenated via '.'"
  type        = string
  default     = "frontend.sdr"
}
variable "siteName" {
  description = "k8s site name in F5 Distributed Cloud hosting openwebrx"
  type        = string
  default     = ""
}
variable "volterraP12" {
  description = "Location of volterra p12 file"
  type        = string
  default     = null
}
variable "volterraUrl" {
  description = "url of volterra api"
  type        = string
  default     = null
}
variable "volterraCaCert" {
  description = "public_server_ca.crt file (only required for non-production tenants"
  type        = string
  default     = null
}
