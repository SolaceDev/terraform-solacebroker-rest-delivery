# Output variable definitions

output "rest_delivery_point" {
  value       = try(solacebroker_msg_vpn_rest_delivery_point.main[0], null)
  description = "A REST Delivery Point manages delivery of messages from queues to a named list of REST Consumers."
}

output "rest_consumer" {
  value       = try(solacebroker_msg_vpn_rest_delivery_point_rest_consumer.main[0], null)
  description = "REST Consumer objects establish HTTP connectivity to REST consumer applications who wish to receive messages from a broker."
}

output "queue_binding" {
  value       = try(solacebroker_msg_vpn_rest_delivery_point_queue_binding.main, null)
  description = "A Queue Binding for a REST Delivery Point attracts messages to be delivered to REST consumers. If the queue does not exist it can be created subsequently, and once the queue is operational the broker performs the queue binding. Removing the queue binding does not delete the queue itself. Similarly, removing the queue does not remove the queue binding, which fails until the queue is recreated or the queue binding is deleted."
}

output "request_headers" {
  value       = var.request_headers
  description = "Reflects the list of request headers passed to the REST Delivery Point"
}

