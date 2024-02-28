provider "solacebroker" {
  username = "admin"
  password = "admin"
  url      = "http://localhost:8080"
}

resource "solacebroker_msg_vpn_queue" "myqueue" {
  msg_vpn_name = "default"
  queue_name   = "my_queue"
  permission   = "consume"
  ingress_enabled = true
  egress_enabled = true
}

resource "solacebroker_msg_vpn_queue" "myqueue2" {
  msg_vpn_name = "default"
  queue_name   = "my_queue2"
  permission   = "consume"
  ingress_enabled = true
  egress_enabled = true
}

module "testrdp" {
  source                  = "../../internal/gen-template"
  
  msg_vpn_name            = "default"
  queue_name              = solacebroker_msg_vpn_queue.myqueue.queue_name
  url                     = "http://example.com/$${msgId()}"
  rest_delivery_point_name = "my_rdp"
  request_headers = [
    {
      header_name  = "header1"
      header_value = "$${uuid()}"
    },
    {
      header_name  = "header2"
      header_value = "value2"
    }
  ]
}

module "testrdp2" {
  source                  = "../../internal/gen-template"
  
  msg_vpn_name            = "default"
  queue_name              = solacebroker_msg_vpn_queue.myqueue2.queue_name
  url                     = "http://example.com/$${msgId()}2"
  rest_delivery_point_name = module.testrdp.rest_delivery_point.rest_delivery_point_name
  append_queue_binding_to_existing_rdp = true
  request_headers = module.testrdp.request_headers
}

output "rdp" {
  value = module.testrdp.rest_delivery_point
}

output "consumer" {
  value = module.testrdp.rest_consumer
  sensitive = true
}

output "queue_binding" {
  value = module.testrdp.queue_binding
}

output "request_headers" {
  value = module.testrdp.request_headers
}

resource "solacebroker_msg_vpn_rest_delivery_point_queue_binding_protected_request_header" "test" {
  msg_vpn_name             = module.testrdp.rest_delivery_point.msg_vpn_name
  rest_delivery_point_name = module.testrdp.rest_delivery_point.rest_delivery_point_name
  queue_binding_name       = module.testrdp.queue_binding.queue_binding_name
  header_name              = "protected_header1"
  header_value             = "protected_value1"
}

resource "solacebroker_msg_vpn_rest_delivery_point_queue_binding_protected_request_header" "test2" {
  msg_vpn_name             = module.testrdp.rest_delivery_point.msg_vpn_name
  rest_delivery_point_name = module.testrdp.rest_delivery_point.rest_delivery_point_name
  queue_binding_name       = module.testrdp2.queue_binding.queue_binding_name
  header_name              = "protected_header1"
  header_value             = "protected_value1"
}
