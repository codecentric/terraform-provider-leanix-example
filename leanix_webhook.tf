locals {
  api-gateway-url = "${aws_api_gateway_deployment.example.invoke_url}/${aws_api_gateway_resource.example.path_part}"
}

resource "leanix_webhook_subscription" "example" {
  identifier           = "${local.project-name}-${substr(md5(substr(var.leanix_api_token, 0, 4)), 0, 8)}"
  target_url           = "${local.api-gateway-url}"
  target_method        = "POST"
  workspace_constraint = "ANY"
  active               = true
  workspace_id         = "8751abbf-8093-410d-a090-10c7735952cf"

  tag_set {
    tags = ["pathfinder", "FACT_SHEET_CREATED"]
  }

  tag_set {
    tags = ["pathfinder", "FACT_SHEET_DELETED"]
  }
}
