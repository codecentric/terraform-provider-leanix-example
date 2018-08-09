output "curl" {
  value = "curl -H 'Content-Type: application/json' -XPOST -d'{\"a\":\"b\"}' ${local.api-gateway-url}"
}