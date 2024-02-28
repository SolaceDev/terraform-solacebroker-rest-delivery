# Output variable definitions

output "rest_delivery_point" {
  value       = try(solacebroker_msg_vpn_rest_delivery_point.main[0], null)
}

output "rest_consumer" {
  value       = try(solacebroker_msg_vpn_rest_delivery_point_rest_consumer.main[0], null)
}

output "queue_binding" {
  value       = try(solacebroker_msg_vpn_rest_delivery_point_queue_binding.main, null)
}

output "request_headers" {
  value       = var.request_headers
  description = "Reflects the list of request headers passed to the REST Delivery Point"
}
