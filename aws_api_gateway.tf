resource "aws_api_gateway_rest_api" "example" {
  name        = "${local.project-name}"
  description = "${local.project-name} API"
}

resource "aws_api_gateway_resource" "example" {
  rest_api_id = "${aws_api_gateway_rest_api.example.id}"
  parent_id   = "${aws_api_gateway_rest_api.example.root_resource_id}"
  path_part   = "events"
}

resource "aws_api_gateway_method" "example" {
  rest_api_id   = "${aws_api_gateway_rest_api.example.id}"
  resource_id   = "${aws_api_gateway_resource.example.id}"
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "example" {
  rest_api_id = "${aws_api_gateway_rest_api.example.id}"
  resource_id = "${aws_api_gateway_resource.example.id}"
  http_method = "${aws_api_gateway_method.example.http_method}"
  type        = "MOCK"

  request_templates {
    "application/json" = <<JSON
{
  "statusCode": 200
}
JSON
  }
}

resource "aws_api_gateway_integration_response" "example" {
  rest_api_id = "${aws_api_gateway_rest_api.example.id}"
  resource_id = "${aws_api_gateway_resource.example.id}"
  http_method = "${aws_api_gateway_integration.example.http_method}"
  status_code = "200"
}

resource "aws_api_gateway_method_response" "example" {
  rest_api_id = "${aws_api_gateway_rest_api.example.id}"
  resource_id = "${aws_api_gateway_resource.example.id}"
  http_method = "${aws_api_gateway_integration_response.example.http_method}"
  status_code = "${aws_api_gateway_integration_response.example.status_code}"

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_deployment" "example" {
  depends_on  = ["aws_api_gateway_method_response.example"]
  rest_api_id = "${aws_api_gateway_rest_api.example.id}"
  stage_name  = "prod"
}
